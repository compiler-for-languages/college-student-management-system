<%@ page import="java.util.*, com.sms.model.User, com.sms.dao.TeacherStudentsDAO, com.sms.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"TEACHER".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    TeacherStudentsDAO dao = new TeacherStudentsDAO();

    // FIX: use username to find teacher_id
    int teacherId = dao.getTeacherIdByUsername(user.getUsername());

    List<Integer> courses = dao.getCoursesForTeacher(teacherId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Students | Teacher Panel</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="brand-bar">SKG's Student Management System — Teacher Panel</div>

<div class="dashboard-wrapper">
    <div class="dashboard-card">

        <h2 class="dashboard-title">Students Assigned to Your Courses</h2>

        <% if (courses.isEmpty()) { %>

            <p>No courses assigned to you.</p>

        <% } else { %>

            <% for (int cid : courses) { 
                List<Student> studs = dao.getStudentsForCourse(cid);
            %>

                <h3 style="margin-top:20px;color:#b2002d;">Course ID: <%= cid %></h3>

                <% if (studs.isEmpty()) { %>
                    <p>No students assigned.</p>
                <% } else { %>

                <table class="data-table">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>USN</th>
                        <th>Department</th>
                        <th>Semester</th>
                    </tr>

                    <% for (Student s : studs) { %>
                    <tr>
                        <td><%= s.getStudentId() %></td>
                        <td><%= s.getName() %></td>
                        <td><%= s.getUsn() %></td>
                        <td><%= s.getDepartmentId() %></td>
                        <td><%= s.getSemester() %></td>
                    </tr>
                    <% } %>
                </table>

                <% } %>

            <% } %>

        <% } %>

    </div>
</div>

</body>
</html>