<%@ page import="java.util.*, com.sms.dao.StudentDAO, com.sms.dao.CourseDAO, com.sms.model.Student, com.sms.model.Course" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assign Course to Student | Admin</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Assign Course to Student</div>
    </div>

    <div class="dashboard-wrapper">

        <div class="dashboard-card">
            <h2 class="dashboard-title">Assign Course to Student</h2>

            <form action="AssignStudentCourseServlet" method="post" class="auth-form">

                <div class="form-group">
                    <label>Select Student</label>
                    <select name="student_id" required>
                        <%
                            StudentDAO sdao = new StudentDAO();
                            List<Student> slist = sdao.getAllStudents();
                            for (Student s : slist) {
                        %>
                            <option value="<%= s.getStudentId() %>">
                                <%= s.getName() %> ( <%= s.getUsn() %> )
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