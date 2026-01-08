package com.sms.servlet;

import com.sms.dao.FinalGradeDAO;
import com.sms.model.FinalGrade;
import com.sms.utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/ComputeFinalGrade")
public class ComputeFinalGradeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String courseCode = req.getParameter("course_code");
        if (courseCode == null || courseCode.trim().isEmpty()) {
            resp.getWriter().println("Missing course_code");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            // Query students who have either internal_marks or see_marks (use student_course to list students for course)
            String studentsSql = "SELECT sc.student_id FROM student_course sc WHERE sc.course_id = " +
                                 "(SELECT c.course_id FROM course c WHERE c.course_code = ?)";
            PreparedStatement psStu = con.prepareStatement(studentsSql);
            psStu.setString(1, courseCode);
            ResultSet rsStu = psStu.executeQuery();

            FinalGradeDAO fgDao = new FinalGradeDAO();

            while (rsStu.next()) {
                int studentId = rsStu.getInt("student_id");

                // Read internal_marks
                String imSql = "SELECT ia1, ia2, ia3, cta FROM internal_marks WHERE student_id=? AND course_code=?";
                PreparedStatement psIm = con.prepareStatement(imSql);
                psIm.setInt(1, studentId);
                psIm.setString(2, courseCode);
                ResultSet rsIm = psIm.executeQuery();

                int ia1=0, ia2=0, ia3=0, cta=0;
                boolean hasIm = false;
                if (rsIm.next()) {
                    ia1 = rsIm.getInt("ia1");
                    ia2 = rsIm.getInt("ia2");
                    ia3 = rsIm.getInt("ia3");
                    cta = rsIm.getInt("cta");
                    hasIm = true;
                }

                // Read see_marks (use see_scaled if present)
                String seeSql = "SELECT see_scaled, see_raw FROM see_marks WHERE student_id=? AND course_code=?";
                PreparedStatement psSee = con.prepareStatement(seeSql);
                psSee.setInt(1, studentId);
                psSee.setString(2, courseCode);
                ResultSet rsSee = psSee.executeQuery();

                int seeScaled = 0;
                boolean hasSee = false;
                if (rsSee.next()) {
                    // prefer scaled if present (non-null), else try raw and scale externally if needed
                    seeScaled = rsSee.getInt("see_scaled");
                    if (rsSee.wasNull()) {
                        seeScaled = rsSee.getInt("see_raw"); // fallback (assume already scaled or you adjust)
                    }
                    hasSee = true;
                }

                // If neither marks exist, skip
                if (!hasIm && !hasSee) continue;

                // Compute CIE: best two of IA1..IA3 + CTA (CIE out of 50)
                int[] arr = {ia1, ia2, ia3};
                Arrays.sort(arr);
                int bestTwo = arr[1] + arr[2]; // best two (0-40)
                int cie = bestTwo + cta; // 0-50

                // SEE score: assume seeScaled is 0-50 already (if raw is 0-100 adjust)
                int see = seeScaled;

                int total = cie + see; // 0-100

                // Determine grade letter & points (using grading table you uploaded)
                String gradeLetter;
                int gradePoints;

                if (total >= 90) { gradeLetter = "O"; gradePoints = 10; }
                else if (total >= 80) { gradeLetter = "A+"; gradePoints = 9; }
                else if (total >= 70) { gradeLetter = "A"; gradePoints = 8; }
                else if (total >= 60) { gradeLetter = "B+"; gradePoints = 7; }
                else if (total >= 55) { gradeLetter = "B"; gradePoints = 6; }
                else if (total >= 50) { gradeLetter = "C"; gradePoints = 5; }
                else if (total >= 40) { gradeLetter = "P"; gradePoints = 4; }
                else { gradeLetter = "F"; gradePoints = 0; }

                FinalGrade fg = new FinalGrade();
                fg.setStudentId(studentId);
                fg.setCourseCode(courseCode);
                fg.setCieScore(cie);
                fg.setSeeScore(see);
                fg.setTotalScore(total);
                fg.setGradeLetter(gradeLetter);
                fg.setGradePoints(gradePoints);

                // upsert
                fgDao.upsertFinalGrade(fg);
            }

            resp.sendRedirect("viewFinalGrades.jsp?course_code=" + java.net.URLEncoder.encode(courseCode, "UTF-8") + "&done=1");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error computing final grades: " + e.getMessage());
        }
    }
}