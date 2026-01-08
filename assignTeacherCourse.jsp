<%@ page import="java.util.*, com.sms.dao.TeacherDAO, com.sms.dao.CourseDAO, com.sms.model.Teacher, com.sms.model.Course" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assign Course to Teacher | Admin</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Assign Course to Teacher</div>
    </div>

    <div class="dashboard-wrapper">

        <div class="dashboard-card">
            <h2 class="dashboard-title">Assign Course to Teacher</h2>

            <form action="AssignTeacherCourseServlet" method="post" class="auth-form">

                <div class="form-group">
                    <label>Select Teacher</label>
                    <select name="teacher_id" required>
                        <%
                            TeacherDAO tdao = new TeacherDAO();
                            List<Teacher> tlist = tdao.getAllTeachers();
                            for (Teacher t : tlist) {
                        %>
                            <option value="<%= t.getTeacherId() %>">
                                <%= t.getName() %> ( <%= t.getTeacherCode() %> )
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Select Course</label>
                    <select name="course_id" required>
                        <%
                            CourseDAO cdao = new CourseDAO();
                            List<Course> clist = cdao.getAllCourses();
                            for (Course c : clist) {
                        %>
                            <option value="<%= c.getCourseId() %>">
                                <%= c.getCourseCode() %> — <%= c.getCourseName() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <button type="submit" class="primary-btn">Assign Course</button>

            </form>
        </div>

    </div>
</div>
</body>
</html>