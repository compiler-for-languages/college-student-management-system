<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Teacher | Admin</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Add Teacher</div>
    </div>

    <div class="dashboard-wrapper">

        <div class="dashboard-card">
            <h2 class="dashboard-title">Register New Teacher</h2>
            <p class="dashboard-subtitle">Fill all details to add a faculty member</p>

            <form action="AddTeacherServlet" method="post" class="auth-form">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" required>
                </div>

                <div class="form-group">
                    <label>Teacher Code (Login Username)</label>
                    <input type="text" name="tid" required>
                </div>

                <div class="form-group">
                    <label>Department</label>
                    <select name="department_id" required>
                        <option value="1">CSE</option>
                        <option value="2">ISE</option>
                        <option value="3">ECE</option>
                        <option value="4">EEE</option>
                        <option value="5">MECH</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="text" name="password" value="teacher123" required>
                </div>

                <button type="submit" class="primary-btn">Register Teacher</button>

            </form>

        </div>
    </div>
</div>
</body>
</html>