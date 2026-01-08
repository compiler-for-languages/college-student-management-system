<%@ page import="java.util.*, com.sms.dao.IaMarksDAO, com.sms.dao.TeacherStudentsDAO, com.sms.model.IaMark, com.sms.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User u = (User) session.getAttribute("user");

    if (u == null || !"TEACHER".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    TeacherStudentsDAO tdao = new TeacherStudentsDAO();
    int teacherId = tdao.getTeacherId(u.getUserId());

    IaMarksDAO dao = new IaMarksDAO();
    List<IaMark> marks = dao.getMarksForTeacher(teacherId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>View IA Marks | Teacher</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="brand-bar">SKG's Student Management System — IA Marks</div>

<div class="dashboard-wrapper">
    <div class="dashboard-card">

        <h2 class="dashboard-title">IA Marks Entered</h2>
        <p class="dashboard-subtitle">Best Two = IA out of 40</p>

        <% if (marks.size() == 0) { %>

            <p>No IA marks found for your courses.</p>

        <% } else { %>

        <table class="data-table">
            <tr>
                <th>Course</th>
                <th>Student</th>
                <th>USN</th>
                <th>IA1</th>
                <th>IA2</th>
                <th>IA3</th>
                <th>CTA</th>
                <th>Best Two (40)</th>
            </tr>

            <% for (IaMark m : marks) { %>
            <tr>
                <td><%= m.getCourseCode() %></td>
                <td><%= m.getStudentName() %></td>
                <td><%= m.getUsn() %></td>
                <td><%= m.getIa1() %></td>
                <td><%= m.getIa2() %></td>
                <td><%= m.getIa3() %></td>
                <td><%= m.getCta() %></td>
                <td><%= m.getBestTwoTotal() %></td>
            </tr>
            <% } %>

        </table>

        <% } %>

    </div>
</div>

</body>
</html>