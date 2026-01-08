package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.sms.utils.DBConnection;

@WebServlet("/MarkAttendanceServlet")
public class MarkAttendanceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int courseId = Integer.parseInt(request.getParameter("course_id"));
        LocalDate today = LocalDate.now();

        try (Connection con = DBConnection.getConnection()) {

            // 1️⃣ Convert course_id → course_code
            String getCodeSql = "SELECT course_code FROM course WHERE course_id = ?";
            PreparedStatement ps1 = con.prepareStatement(getCodeSql);
            ps1.setInt(1, courseId);
            ResultSet rs = ps1.executeQuery();

            String courseCode = null;
            if (rs.next()) {
                courseCode = rs.getString("course_code");
            }

            if (courseCode == null) {
                throw new RuntimeException("Invalid course_id");
            }

            // 2️⃣ Insert attendance for each student
            for (String param : request.getParameterMap().keySet()) {

                if (param.startsWith("status_")) {

                    int studentId = Integer.parseInt(param.substring(7));
                    String status = request.getParameter(param);

                    String sql =
                        "INSERT INTO attendance(student_id, course_code, attendance_date, status) " +
                        "VALUES (?, ?, ?, ?)";

                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, studentId);
                    ps.setString(2, courseCode);
                    ps.setDate(3, java.sql.Date.valueOf(today));
                    ps.setString(4, status);

                    ps.executeUpdate();
                }
            }

            response.sendRedirect("markAttendance.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving attendance: " + e.getMessage());
        }
    }
}