<%@ page import="com.sms.model.User, java.sql.*, com.sms.utils.DBConnection" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"STUDENT".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    String studentName = "";
    try (Connection con = DBConnection.getConnection()) {
        PreparedStatement ps = con.prepareStatement(
            "SELECT name FROM student WHERE user_id = ?"
        );
        ps.setInt(1, u.getUserId());
        ResultSet rs = ps.executeQuery();
        if (rs.next()) studentName = rs.getString("name");
    } catch (Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard | SKG</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="bg">

    <!-- Top Brand Bar -->
    <div class="brand-bar">
        <div class="brand-name">
            SKG's Student Management System — Student Panel
            <span style="float:right; font-size:16px;">
                Welcome, <%= studentName %>
            </span>
        </div>
    </div>

    <div class="dashboard-wrapper">
        <div class="dashboard-card">

            <h2 class="dashboard-title">Student Dashboard</h2>
            <p class="dashboard-subtitle">
                View your courses, marks, attendance and results
            </p>

            <div class="dashboard-grid">

                <a class="dashboard-option" href="studentCourses.jsp">
                    <h3>My Courses</h3>
                    <p>Courses registered for this semester</p>
                </a>

                <a class="dashboard-option" href="viewIaMarksStudent.jsp">
                    <h3>IA Marks</h3>
                    <p>IA-1, IA-2, IA-3 & best of two</p>
                </a>

                <a class="dashboard-option" href="viewFinalGradesStudent.jsp">
                    <h3>Final Result</h3>
                    <p>SEE marks, total score & grade</p>
                </a>

                <a class="dashboard-option" href="viewAttendanceStudent.jsp">
                    <h3>Attendance</h3>
                    <p>Attendance percentage per course</p>
                </a>

                <a class="dashboard-option" href="index.jsp">
                    <h3>Logout</h3>
                    <p>Return to login page</p>
                </a>

            </div>
        </div>
    </div>
</div>
</body>
</html>