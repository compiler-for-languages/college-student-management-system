<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Student Management System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="bg">
    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System</div>
    </div>

    <div class="auth-wrapper">
        <div class="auth-card">
            <h2 class="auth-title">Welcome</h2>
            <p class="auth-subtitle">Select login type and sign in to continue</p>

            <!-- Role selector -->
            <div class="role-switch">
                <button type="button" class="role-btn active" data-role="STUDENT">Student</button>
                <button type="button" class="role-btn" data-role="TEACHER">Teacher</button>
                <button type="button" class="role-btn" data-role="ADMIN">Admin</button>
            </div>

            <form action="LoginServlet" method="post" class="auth-form">
                <input type="hidden" name="role" id="roleInput" value="STUDENT">

                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>

                <button type="submit" class="primary-btn">Login</button>
            </form>

            <p class="footer-note">
                CIE · SEE · Attendance · CGPA – Developed by SKG and buddy
            </p>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {

    const buttons = document.querySelectorAll(".role-btn");
    const roleInput = document.getElementById("roleInput");

    buttons.forEach(btn => {
        btn.addEventListener("click", () => {
            buttons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            roleInput.value = btn.getAttribute("data-role");
            console.log("Role Selected:", roleInput.value);
        });
    });

});
</script>
</body>
</html>
