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

    // Get course_id + course_code for teacher
    List<Map<String,Object>> courses = dao.getCoursesWithCodes(teacherId);

    String selectedCourse = request.getParameter("course_id");
    List<Student> studs = null;

    if (selectedCourse != null) {
        studs = dao.getStudentsForCourse(Integer.parseInt(selectedCourse));
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance | Teacher</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="brand-bar">
    <div class="brand-name">SKG's Student Management System — Mark Attendance</div>
</div>

<div class="dashboard-wrapper">
<div class="dashboard-card">

<h2 class="dashboard-title">Mark Attendance</h2>
<p class="dashboard-subtitle">Select course and mark Present/Absent</p>

<!-- SELECT COURSE -->
<form method="get" class="auth-form">
    <div class="form-group">
        <label>Select Course</label>
        <select name="course_id" required onchange="this.form.submit()">
            <option value="">-- Select Course --</option>
            <% for (Map<String, Object> c : courses) { %>
                <option value="<%= c.get("course_id") %>"
                        <%= (selectedCourse != null && selectedCourse.equals(c.get("course_id")+"")) ? "selected" : "" %>>
                    <%= c.get("course_code") %>
                </option>
            <% } %>
        </select>
    </div>
</form>

<% if (studs != null) { %>

<!-- STUDENT LIST + STATUS -->
<form method="post" action="MarkAttendanceServlet" class="auth-form">

    <input type="hidden" name="course_id" value="<%= selectedCourse %>">

    <table class="data-table">
        <tr>
            <th>Name</th>
            <th>USN</th>
            <th>Status</th>
        </tr>

        <% for (Student s : studs) { %>
        <tr>
            <td><%= s.getName() %></td>
            <td><%= s.getUsn() %></td>
            <td>
                <select name="status_<%= s.getStudentId() %>">
                    <option value="P">Present</option>
                    <option value="A">Absent</option>
                </select>
            </td>
        </tr>
        <% } %>
    </table>

    <button type="submit" class="primary-btn">Save Attendance</button>
</form>

<% } %>

</div>
</div>

</body>
</html>