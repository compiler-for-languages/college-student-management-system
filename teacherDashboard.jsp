<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sms.model.User" %>
<%@ page import="com.sms.dao.TeacherDAO" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    TeacherDAO tdao = new TeacherDAO();
    String teacherName = tdao.getTeacherNameByUserId(u.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher Dashboard | Student Management System</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- Top Bar -->
    <div class="brand-bar">
        <div class="brand-name">
            SKG's Student Management System — Teacher Panel
        </div>

        <!-- ⭐ REAL TEACHER NAME -->
        <div style="float:right; font-size:18px; margin-top:-28px; color:#b2002d; font-weight:600;">
            Welcome, <%= teacherName %>
        </div>
    </div>

    <div class="dashboard-wrapper">

        <div class="dashboard-card">
            <h2 class="dashboard-title">Teacher Dashboard</h2>
            <p class="dashboard-subtitle">Manage your courses and student performance</p>

            <div class="dashboard-grid">

                <a class="dashboard-option" href="teacherStudents.jsp">
                    <h3>View My Students</h3>
                    <p>See all students enrolled in your courses</p>
                </a>

                <a class="dashboard-option" href="enterIaMarks.jsp">
                    <h3>Enter IA Marks</h3>
                    <p>IA-1, IA-2, IA-3 marks entry for your subjects</p>
                </a>


          <a class="dashboard-option" href="viewIamarks.jsp">
    <h3>View IA Marks</h3>
    <p>Check IA marks entered for your courses</p>
            </a>
                <a class="dashboard-option" href="markAttendance.jsp">
                    <h3>Mark Attendance</h3>
                    <p>Daily attendance entry for each course</p>
                </a>
                
                
                
                
       
                     
                                         
<a class="dashboard-option" href="viewAttendance.jsp">
    <h3>View Attendance</h3>
    <p>See attendance records for each course</p>
</a>
                <a class="dashboard-option" href="enterSeeMarks.jsp">
                    <h3>Update SEE Marks</h3>
                    <p>Record final semester exam scores</p>
                </a>

        
<a class="dashboard-option" href="computeFinalGrade.jsp">
    <h3>Compute Final Grades</h3>
    <p>Generate AICTE grade based on total marks</p>
</a>


<a class="dashboard-option" href="viewFinalGrades.jsp">
    <h3>View Final Grades</h3>
    <p>preview of Grades computed </p>
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