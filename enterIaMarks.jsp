<%@ page import="java.util.*, com.sms.model.User, com.sms.dao.TeacherStudentsDAO, com.sms.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"TEACHER".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    TeacherStudentsDAO dao = new TeacherStudentsDAO();

    int teacherId = dao.getTeacherId(u.getUserId());
    List<String> courseCodes = dao.getAssignedCourseCodes(teacherId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enter IA Marks | Teacher</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="brand-bar">
    <div class="brand-name">SKG's Student Management System — IA Marks Entry</div>
</div>

<div class="dashboard-wrapper">
<div class="dashboard-card">

<h2 class="dashboard-title">Enter IA Marks</h2>
<p class="dashboard-subtitle">System will store IA1, IA2, IA3 & CTA.</p>

<form action="IaMarksServlet" method="post" class="auth-form">

    <!-- SELECT COURSE CODE -->
    <div class="form-group">
        <label>Select Course</label>
        <select name="course_code" required>
            <option value="">-- Select Course --</option>
            <% for (String cc : courseCodes) { %>
                <option value="<%= cc %>"><%= cc %></option>
            <% } %>
        </select>
    </div>

    <!-- SELECT STUDENT -->
    <div class="form-group">
        <label>Select Student</label>
        <select name="student_id" required>
            <option value="">-- Select Student --</option>

            <%  
                for (String cc : courseCodes) {
                    List<Student> list = dao.getStudentsForCourseCode(cc);
                    for (Student s : list) {
            %>
                <option value="<%= s.getStudentId() %>">
                    <%= s.getName() %> ( <%= s.getUsn() %> ) — <%= cc %>
                </option>
            <%  
                    }
                }
            %>
        </select>
    </div>

    <!-- IA1 -->
    <div class="form-group">
        <label>IA1 (0 to 20)</label>
        <input type="number" name="ia1" min="0" max="20" required>
    </div>

    <!-- IA2 -->
    <div class="form-group">
        <label>IA2 (0 to 20)</label>
        <input type="number" name="ia2" min="0" max="20" required>
    </div>

    <!-- IA3 -->
    <div class="form-group">
        <label>IA3 (0 to 20)</label>
        <input type="number" name="ia3" min="0" max="20" required>
    </div>

    <!-- CTA -->
    <div class="form-group">
        <label>CTA (0 to 10)</label>
        <input type="number" name="cta" min="0" max="10" required>
    </div>

    <button type="submit" class="primary-btn">Save IA Marks</button>

</form>

</div>
</div>

</body>
</html>