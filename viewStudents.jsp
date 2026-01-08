<%@ page import="java.util.*, com.sms.dao.StudentDAO, com.sms.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Students | Admin</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">
    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — View Students</div>
    </div>

    <div class="dashboard-wrapper">
        <div class="dashboard-card">

            <h2 class="dashboard-title">All Registered Students</h2>

            <table class="data-table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>USN</th>
                    <th>Department</th>
                    <th>Semester</th>
                </tr>

                <%
                    StudentDAO dao = new StudentDAO();
                    List<Student> list = dao.getAllStudents();

                    for (Student s : list) {

                        int did = s.getDepartmentId();
                        String dept = "";

                        if(did == 1) dept = "CSE";
                        else if(did == 2) dept = "ISE";
                        else if(did == 3) dept = "ECE";
                        else if(did == 4) dept = "EEE";
                        else if(did == 5) dept = "MECH";
                        else dept = "Unknown";
                %>

                <tr>
                    <td><%= s.getStudentId() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getUsn() %></td>
                    <td><%= dept %></td>
                    <td><%= s.getSemester() %></td>
                </tr>

                <% } %>

            </table>

        </div>
    </div>

</div>
</body>
</html>