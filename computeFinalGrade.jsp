<%@ page import="java.util.*, com.sms.model.User, com.sms.dao.TeacherStudentsDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User u = (User) session.getAttribute("user");
    if (u==null || !"TEACHER".equals(u.getRole())) { 
        response.sendRedirect("index.jsp"); 
        return; 
    }

    TeacherStudentsDAO dao = new TeacherStudentsDAO();
    int teacherId = dao.getTeacherId(u.getUserId());
    List<Map<String,Object>> courses = dao.getCoursesWithCodes(teacherId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compute Final Grades | Teacher</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- BRAND BAR -->
    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Compute Final Grades</div>
    </div>

    <div class="dashboard-wrapper">
        <div class="dashboard-card">

            <h2 class="dashboard-title">Compute Final Grades</h2>
            <p class="dashboard-subtitle">
                CIE (50) + SEE (50) → Final Grade according to university rules
            </p>

            <!-- FORM -->
            <form method="post" action="ComputeFinalGrade" class="auth-form">
                
                <div class="form-group">
                    <label>Select Course</label>
                    <select name="course_code" required>
                        <option value="">-- Select Course --</option>
                        <% for (Map<String,Object> c : courses) { %>
                            <option value="<%= c.get("course_code") %>">
                                <%= c.get("course_code") %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <button type="submit" class="primary-btn">Compute & Save Final Grades</button>

            </form>

        </div>
    </div>
</div>

</body>
</html>