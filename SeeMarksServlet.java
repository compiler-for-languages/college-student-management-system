package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.sms.utils.DBConnection;

@WebServlet("/SeeMarksServlet")
public class SeeMarksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseCode = request.getParameter("course_code");

        try (Connection con = DBConnection.getConnection()) {

            for (String param : request.getParameterMap().keySet()) {

                if (param.startsWith("see_")) {

                    int studentId = Integer.parseInt(param.substring(4));
                    int rawMarks = Integer.parseInt(request.getParameter(param));

                    int scaledMarks = rawMarks / 2;   // 100 → 50

                    // Check if the record already exists
                    String check = "SELECT id FROM see_marks WHERE student_id=? AND course_code=?";
                    PreparedStatement ps1 = con.prepareStatement(check);
                    ps1.setInt(1, studentId);
                    ps1.setString(2, courseCode);
                    ResultSet rs = ps1.executeQuery();

                    if (rs.next()) {
                        // ---------- UPDATE ----------
                        String update =
                            "UPDATE see_marks SET see_raw=?, see_scaled=? WHERE student_id=? AND course_code=?";

                        PreparedStatement ps = con.prepareStatement(update);
                        ps.setInt(1, rawMarks);
                        ps.setInt(2, scaledMarks);
                        ps.setInt(3, studentId);
                        ps.setString(4, courseCode);
                        ps.executeUpdate();

                    } else {
                        // ---------- INSERT ----------
                        String insert =
                            "INSERT INTO see_marks(student_id, course_code, see_raw, see_scaled) VALUES(?,?,?,?)";

                        PreparedStatement ps = con.prepareStatement(insert);
                        ps.setInt(1, studentId);
                        ps.setString(2, courseCode);
                        ps.setInt(3, rawMarks);
                        ps.setInt(4, scaledMarks);
                        ps.executeUpdate();
                    }
                }
            }

            response.sendRedirect("enterSeeMarks.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving SEE marks: " + e.getMessage());
        }
    }
}