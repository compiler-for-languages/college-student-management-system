<%@ page import="java.util.*, com.sms.model.User, com.sms.dao.TeacherStudentsDAO, com.sms.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"TEACHER".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    TeacherStudentsDAO dao = new TeacherStudentsDAO();
    int teacherId = dao.getTeacherId(u.getUserId());

    List<Map<String,Object>> courses = dao.getCoursesWithCodes(teacherId);

    String selectedCourse = request.getParameter("course_code");
    List<Student> studs = null;

    if (selectedCourse != null) {
        studs = dao.getStudentsForCourseCode(selectedCourse);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Enter SEE Marks</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="brand-bar">SKG's Student Management System — Enter SEE Marks</div>

<div class="dashboard-wrapper">
<div class="dashboard-card">

<h2 class="dashboard-title">Enter SEE Marks</h2>

<!-- SELECT COURSE -->
<form method="get" class="auth-form">
    <div class="form-group">
        <label>Select Course</label>
        <select name="course_code" required onchange="this.form.submit()">
            <option value="">-- Select Course --</option>
            <% for (Map<String,Object> c : courses) { %>
                <option value="<%= c.get("course_code") %>"
                    <%= (selectedCourse != null && selectedCourse.equals(c.get("course_code"))) ? "selected" : "" %>>
                    <%= c.get("course_code") %>
                </option>
            <% } %>
        </select>
    </div>
</form>

<% if (studs != null) { %>

<form method="post" action="SeeMarksServlet" class="auth-form">
    <input type="hidden" name="course_code" value="<%= selectedCourse %>">

    <table class="data-table">
        <tr>
            <th>Name</th>
            <th>USN</th>
            <th>SEE Marks (out of 100)</th>
        </tr>

        <% for (Student s : studs) { %>
        <tr>
            <td><%= s.getName() %></td>
            <td><%= s.getUsn() %></td>
            <td>
                <input type="number" name="see_<%= s.getStudentId() %>" min="0" max="100" required>
            </td>
        </tr>
        <% } %>
    </table>

    <button type="submit" class="primary-btn">Save SEE Marks</button>
</form>

<% } %>

</div>
</div>

</body>
</html>