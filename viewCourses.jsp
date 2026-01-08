<%@ page import="java.util.*, com.sms.dao.CourseDAO, com.sms.model.Course" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Courses | Admin</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — View Courses</div>
    </div>

    <div class="dashboard-wrapper">

        <div class="dashboard-card">
            <h2 class="dashboard-title">All Courses</h2>

            <table class="data-table">
                <tr>
                    <th>ID</th>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Sem</th>
                    <th>Dept</th>
                    <th>Credits</th>
                </tr>

                <%
                    CourseDAO dao = new CourseDAO();
                    List<Course> list = dao.getAllCourses();

                    for (Course c : list) {
                %>
                <tr>
                    <td><%= c.getCourseId() %></td>
                    <td><%= c.getCourseCode() %></td>
                    <td><%= c.getCourseName() %></td>
                    <td><%= c.getSemester() %></td>
                    <td><%= c.getDepartment() %></td>
                    <td><%= c.getCredits() %></td>
                </tr>
                <% } %>

            </table>

        </div>

    </div>
</div>

</body>
</html>