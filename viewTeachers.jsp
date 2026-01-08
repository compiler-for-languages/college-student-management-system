<%@ page import="java.util.*, com.sms.dao.TeacherDAO, com.sms.model.Teacher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Teachers | Admin</title>
    <link rel="stylesheet" href="style.css">
</head>



<body>

<div class="bg">

    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Teachers</div>
    </div>

    <div class="dashboard-wrapper">

        <div class="dashboard-card">
            <h2 class="dashboard-title">All Registered Teachers</h2>

            <table class="data-table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Teacher Code</th>
                    <th>Department</th>
                </tr>

                <%
                    TeacherDAO dao = new TeacherDAO();
                    List<Teacher> list = dao.getAllTeachers();

                    for (Teacher t : list) {

                        int did = t.getDepartmentId();
                        String dept = "";

                        if(did == 1) dept = "CSE";
                        else if(did == 2) dept = "ISE";
                        else if(did == 3) dept = "ECE";
                        else if(did == 4) dept = "EEE";
                        else if(did == 5) dept = "MECH";
                        else dept = "Unknown";
                %>

                <tr>
                    <td><%= t.getTeacherId() %></td>
                    <td><%= t.getName() %></td>
                    <td><%= t.getTeacherCode() %></td>
                    <td><%= dept %></td>
                </tr>

                <% } %>

            </table>
        </div>

    </div>
</div>
</body>
</html>