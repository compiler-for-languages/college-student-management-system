<%@ page import="java.util.*, com.sms.dao.CourseDAO, com.sms.model.Course" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Courses | Admin</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<div class="bg">

    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Manage Courses</div>
    </div>

    <div class="dashboard-wrapper">

        <!-- ADD COURSE FORM -->
        <div class="dashboard-card">
            <h2 class="dashboard-title">Add New Course</h2>

            <form action="AddCourseServlet" method="post" class="auth-form">

                <div class="form-group">
                    <label>Course Code</label>
                    <input type="text" name="course_code" required>
                </div>

                <div class="form-group">
                    <label>Course Name</label>
                    <input type="text" name="course_name" required>
                </div>

                <div class="form-group">
                    <label>Credits</label>
                    <input type="number" name="credits" required min="1" max="5">
                </div>

                <div class="form-group">
                    <label>Semester</label>
                    <select name="semester" required>
                        <%
                            for(int i=1; i<=8; i++){
                                out.println("<option value=\"" + i + "\">Semester " + i + "</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Department</label>
                    <select name="department" required>
                        <option value="CSE">CSE</option>
                        <option value="ISE">ISE</option>
                        <option value="ECE">ECE</option>
                        <option value="EEE">EEE</option>
                        <option value="MECH">MECH</option>
                    </select>
                </div>

                <button type="submit" class="primary-btn">Add Course</button>
            </form>
        </div>


        <!-- VIEW ALL COURSES TABLE -->
        <div class="dashboard-card" style="margin-top:20px;">
            <h2 class="dashboard-title">All Courses</h2>

            <table class="data-table">
                <tr>
                    <th>ID</th>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Credits</th>
                    <th>Semester</th>
                    <th>Department</th>
                </tr>

                <%
                    CourseDAO dao = new CourseDAO();
                    List<Course> list = dao.getAllCourses();

                    for (Course c : list) {
                %>
                <tr>
                    <td><%= c.getCourseId() %></td>
                    <td><%= c.getCourseCode() %></td>
                    <td><%= c.getCourseName() %></td>
                    <td><%= c.getCredits() %></td>
                    <td><%= c.getSemester() %></td>
                    <td><%= c.getDepartment() %></td>
                </tr>
                <% } %>

            </table>
        </div>

    </div>
</div>

</body>
</html>