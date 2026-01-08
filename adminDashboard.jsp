<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Student Management System</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- Top Brand Bar (SAME AS LOGIN PAGE) -->
    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Admin Panel</div>
    </div>

    <div class="dashboard-wrapper">

        <div class="dashboard-card">
            <h2 class="dashboard-title">Admin Dashboard</h2>
            <p class="dashboard-subtitle">Manage departments · teachers · students</p>

            <!-- GRID OF OPTIONS -->
            <div class="dashboard-grid">

                <a class="dashboard-option" href="addStudent.jsp">
                    <h3>Add Student</h3>
                    <p>Create new student records and assign courses</p>
                </a>

                <a class="dashboard-option" href="addTeacher.jsp">
                    <h3>Add Teacher</h3>
                    <p>Register teachers and assign courses</p>
                </a>

                <a class="dashboard-option" href="viewStudents.jsp">
                    <h3>View All Students</h3>
                    <p>Check IA, CIE, SEE, Attendance</p>
                </a>

                <a class="dashboard-option" href="viewTeachers.jsp">
                    <h3>View All Teachers</h3>
                    <p>See teacher details and assigned subjects</p>
                </a>

                <a class="dashboard-option" href="manageCourses.jsp">
                    <h3>Manage Courses</h3>
                    <p>Add or modify course details</p>
                </a>

           <a class="dashboard-option" href="manageAssignments.jsp">
          <h3>Manage Assignments</h3>
      <p>Assign courses to Students and Teachers</p>

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