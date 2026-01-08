<%@ page import="java.util.*, java.sql.*, com.sms.model.User, com.sms.utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"STUDENT".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    int studentId = -1;
    String studentName = "";

    try (Connection con = DBConnection.getConnection()) {

        // get student_id and name
        PreparedStatement ps = con.prepareStatement(
            "SELECT student_id, name FROM student WHERE user_id=?"
        );
        ps.setInt(1, u.getUserId());
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            studentId = rs.getInt("student_id");
            studentName = rs.getString("name");
        }
    } catch (Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Attendance | SKG</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- Brand Bar -->
    <div class="brand-bar">
        <div class="brand-name">
            SKG's Student Management System — Attendance
            <span style="float:right; font-size:16px;">
                Welcome, <%= studentName %>
            </span>
        </div>
    </div>

    <div class="dashboard-wrapper">
        <div class="dashboard-card">

            <h2 class="dashboard-title">My Attendance Percentage</h2>
            <p class="dashboard-subtitle">
                Course-wise attendance calculated automatically
            </p>

            <table class="data-table">
                <tr>
                    <th>Course Code</th>
                    <th>Total Classes</th>
                    <th>Classes Attended</th>
                    <th>Attendance %</th>
                </tr>

<%
    try (Connection con = DBConnection.getConnection()) {

        String sql =
            "SELECT a.course_code, " +
            "COUNT(*) AS total_classes, " +
            "SUM(CASE WHEN a.status='P' THEN 1 ELSE 0 END) AS present_classes " +
            "FROM attendance a " +
            "WHERE a.student_id=? " +
            "GROUP BY a.course_code";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();

        boolean hasData = false;

        while (rs.next()) {
            hasData = true;

            int total = rs.getInt("total_classes");
            int present = rs.getInt("present_classes");
            double percent = (total == 0) ? 0 : (present * 100.0 / total);
%>
                <tr>
                    <td><%= rs.getString("course_code") %></td>
                    <td><%= total %></td>
                    <td><%= present %></td>
                    <td><%= String.format("%.2f", percent) %> %</td>
                </tr>
<%
        }

        if (!hasData) {
%>
                <tr>
                    <td colspan="4">Attendance not recorded yet.</td>
                </tr>
<%
        }

    } catch (Exception e) { e.printStackTrace(); }
%>

            </table>

        </div>
    </div>
</div>
</body>
</html>