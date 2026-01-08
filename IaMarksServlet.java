package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.sms.utils.DBConnection;

@WebServlet("/IaMarksServlet")
public class IaMarksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId   = Integer.parseInt(request.getParameter("student_id"));
        String courseCode = request.getParameter("course_code");

        int ia1 = Integer.parseInt(request.getParameter("ia1"));
        int ia2 = Integer.parseInt(request.getParameter("ia2"));
        int ia3 = Integer.parseInt(request.getParameter("ia3"));
        int cta = Integer.parseInt(request.getParameter("cta"));

        try (Connection con = DBConnection.getConnection()) {

            // Check if record exists (student_id + course_code is UNIQUE)
            String checkSql = "SELECT id FROM internal_marks WHERE student_id=? AND course_code=?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, studentId);
            checkPs.setString(2, courseCode);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // ---------- UPDATE EXISTING RECORD ----------
                String updateSql =
                    "UPDATE internal_marks SET ia1=?, ia2=?, ia3=?, cta=? " +
                    "WHERE student_id=? AND course_code=?";

                PreparedStatement ps = con.prepareStatement(updateSql);
                ps.setInt(1, ia1);
                ps.setInt(2, ia2);
                ps.setInt(3, ia3);
                ps.setInt(4, cta);
                ps.setInt(5, studentId);
                ps.setString(6, courseCode);

                ps.executeUpdate();

            } else {
                // ---------- INSERT NEW RECORD ----------
                String insertSql =
                    "INSERT INTO internal_marks(student_id, course_code, ia1, ia2, ia3, cta) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

                PreparedStatement ps = con.prepareStatement(insertSql);
                ps.setInt(1, studentId);
                ps.setString(2, courseCode);
                ps.setInt(3, ia1);
                ps.setInt(4, ia2);
                ps.setInt(5, ia3);
                ps.setInt(6, cta);

                ps.executeUpdate();
            }

            // Redirect back to Enter IA page
            response.sendRedirect("enterIaMarks.jsp?status=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving IA marks: " + e.getMessage());
        }
    }
}