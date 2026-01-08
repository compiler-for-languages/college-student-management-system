<%@ page import="com.sms.model.User, java.sql.*, com.sms.utils.DBConnection, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"STUDENT".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    int studentId = 0;
    String studentName = "";

    List<Map<String,Object>> courses = new ArrayList<>();

    try (Connection con = DBConnection.getConnection()) {

        // Get student_id + name (SAME LOGIC AS DASHBOARD)
        PreparedStatement ps1 = con.prepareStatement(
            "SELECT student_id, name FROM student WHERE user_id = ?"
        );
        ps1.setInt(1, u.getUserId());
        ResultSet rs1 = ps1.executeQuery();

        if (rs1.next()) {
            studentId = rs1.getInt("student_id");
            studentName = rs1.getString("name");
        }

        // Get registered courses
        PreparedStatement ps2 = con.prepareStatement(
            "SELECT c.course_code, c.course_name, c.credits, c.semester, c.department " +
            "FROM student_course sc " +
            "JOIN course c ON sc.course_id = c.course_id " +
            "WHERE sc.student_id = ? " +
            "ORDER BY c.course_code"
        );
        ps2.setInt(1, studentId);
        ResultSet rs2 = ps2.executeQuery();

        while (rs2.next()) {
            Map<String,Object> row = new HashMap<>();
            row.put("course_code", rs2.getString("course_code"));
            row.put("course_name", rs2.getString("course_name"));
            row.put("credits", rs2.getInt("credits"));
            row.put("semester", rs2.getInt("semester"));
            row.put("department", rs2.getString("department"));
            courses.add(row);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Courses | SKG</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- Top Brand Bar -->
    <div class="brand-bar">
        <div class="brand-name">
            SKG's Student Management System — Student Panel
            <span style="float:right; font-size:16px;">
                Welcome, <%= studentName %>
            </span>
        </div>
    </div>

    <div class="dashboard-wrapper">
        <div class="dashboard-card">

            <h2 class="dashboard-title">My Courses</h2>
            <p class="dashboard-subtitle">
                Courses registered for the current semester
            </p>

            <table class="data-table">
                <tr>
                    <th>Course Code</th>
                    <th>Course Name</th>
                    <th>Credits</th>
                    <th>Semester</th>
                    <th>Department</th>
                </tr>

                <% if (courses.isEmpty()) { %>
                    <tr>
                        <td colspan="5">No courses registered.</td>
                    </tr>
                <% } else {
                    for (Map<String,Object> c : courses) {
                %>
                <tr>
                    <td><%= c.get("course_code") %></td>
                    <td><%= c.get("course_name") %></td>
                    <td><%= c.get("credits") %></td>
                    <td><%= c.get("semester") %></td>
                    <td><%= c.get("department") %></td>
                </tr>
                <% } } %>

            </table>

        </div>
    </div>
</div>
</body>
</html>