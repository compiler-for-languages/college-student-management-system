<%@ page import="java.util.*, com.sms.model.User, com.sms.dao.TeacherStudentsDAO, com.sms.dao.AttendanceDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"TEACHER".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    TeacherStudentsDAO tdao = new TeacherStudentsDAO();
    int teacherId = tdao.getTeacherId(u.getUserId());

    // Courses teacher handles
    List<Map<String,Object>> courses = tdao.getCoursesWithCodes(teacherId);

    String selectedCourseCode = request.getParameter("course_code");
    String selectedDate = request.getParameter("attendance_date");

    List<Map<String,Object>> attendance = null;

    if (selectedCourseCode != null && selectedDate != null) {
        AttendanceDAO adao = new AttendanceDAO();
        attendance = adao.getAttendance(selectedCourseCode, selectedDate);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Attendance | Teacher</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="brand-bar">
    <div class="brand-name">SKG's Student Management System — Attendance Records</div>
</div>

<div class="dashboard-wrapper">
<div class="dashboard-card">

<h2 class="dashboard-title">View Attendance</h2>
<p class="dashboard-subtitle">Select course & date to view attendance list</p>

<!-- SELECT COURSE + DATE -->
<form method="get" class="auth-form">
    
    <div class="form-group">
        <label>Select Course</label>
        <select name="course_code" required>
            <option value="">-- Select Course --</option>
            <% for (Map<String,Object> c : courses) { %>
                <option value="<%= c.get("course_code") %>"
                    <%= (selectedCourseCode != null && selectedCourseCode.equals(c.get("course_code"))) ? "selected" : "" %>>
                    <%= c.get("course_code") %>
                </option>
            <% } %>
        </select>
    </div>

    <div class="form-group">
        <label>Select Date</label>
        <input type="date" name="attendance_date" required
               value="<%= (selectedDate != null ? selectedDate : "") %>">
    </div>

    <button type="submit" class="primary-btn">View Attendance</button>
</form>



<% if (attendance != null) { %>

<h3 style="margin-top:25px;">Attendance for <%= selectedCourseCode %> on <%= selectedDate %></h3>

<table class="data-table">
    <tr>
        <th>Student Name</th>
        <th>USN</th>
        <th>Status</th>
    </tr>



    <%  
        if (attendance.size() == 0) { 
    %>
            <tr><td colspan="3">No attendance found for this date.</td></tr>
    <%  
        } else {
            for (Map<String,Object> a : attendance) { 
    %>
        <tr>
            <td><%= a.get("name") %></td>
            <td><%= a.get("usn") %></td>
            <td><%= a.get("status") %></td>
        </tr>
    <%      }
        } 
    %>

</table>

<% } %>

</div>
</div>

</body>
</html>