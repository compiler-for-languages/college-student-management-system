<%@ page import="java.util.*, java.sql.*, com.sms.utils.DBConnection, com.sms.model.User, com.sms.dao.TeacherStudentsDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User u = (User) session.getAttribute("user");
    if (u==null || !"TEACHER".equals(u.getRole())) { response.sendRedirect("index.jsp"); return; }

    TeacherStudentsDAO dao = new TeacherStudentsDAO();
    int teacherId = dao.getTeacherId(u.getUserId());
    List<Map<String,Object>> courses = dao.getCoursesWithCodes(teacherId);

    String courseCode = request.getParameter("course_code");
    List<Map<String,Object>> rows = new ArrayList<>();

    if (courseCode != null && !courseCode.isEmpty()) {
        try (Connection con = DBConnection.getConnection()) {
            String sql =
                "SELECT fg.student_id, s.name, s.usn, fg.cie_score, fg.see_score, fg.total_score, fg.grade_letter, fg.grade_points " +
                "FROM final_grade fg JOIN student s ON fg.student_id = s.student_id " +
                "WHERE fg.course_code = ? ORDER BY s.usn";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, courseCode);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String,Object> r = new HashMap<>();
                r.put("student_id", rs.getInt("student_id"));
                r.put("name", rs.getString("name"));
                r.put("usn", rs.getString("usn"));
                r.put("cie", rs.getInt("cie_score"));
                r.put("see", rs.getInt("see_score"));
                r.put("total", rs.getInt("total_score"));
                r.put("grade", rs.getString("grade_letter"));
                r.put("points", rs.getInt("grade_points"));
                rows.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Final Grades | Teacher</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- Top Bar -->
    <div class="brand-bar">
        <div class="brand-name">SKG's Student Management System — Final Grades</div>
    </div>

    <div class="dashboard-wrapper">
        <div class="dashboard-card">

            <h2 class="dashboard-title">View Final Grades</h2>
            <p class="dashboard-subtitle">CIE (50) + SEE (50) → Total → Grade</p>

            <!-- Course Selection -->
            <form method="get" class="auth-form">
                <div class="form-group">
                    <label>Select Course</label>
                    <select name="course_code" onchange="this.form.submit()" required>
                        <option value="">-- Select course --</option>
                        <% for (Map<String,Object> c : courses) { %>
                            <option value="<%= c.get("course_code") %>"
                                <%= (courseCode!=null && courseCode.equals(c.get("course_code"))) ? "selected":"" %>>
                                <%= c.get("course_code") %>
                            </option>
                        <% } %>
                    </select>
                </div>
            </form>

            <% if (courseCode != null && !courseCode.isEmpty()) { %>

                <h3 style="margin-top:20px; color:#b2002d;">Grades for <%= courseCode %></h3>

                <% if (rows.isEmpty()) { %>

                    <p>No final grades found. Compute grades first.</p>

                <% } else { %>

                <table class="data-table">
                    <tr>
                        <th>USN</th>
                        <th>Name</th>
                        <th>CIE (50)</th>
                        <th>SEE (50)</th>
                        <th>Total</th>
                        <th>Grade</th>
                        <th>Points</th>
                    </tr>

                    <% for (Map<String,Object> r : rows) { %>
                        <tr>
                            <td><%= r.get("usn") %></td>
                            <td><%= r.get("name") %></td>
                            <td><%= r.get("cie") %></td>
                            <td><%= r.get("see") %></td>
                            <td><%= r.get("total") %></td>
                            <td><%= r.get("grade") %></td>
                            <td><%= r.get("points") %></td>
                        </tr>
                    <% } %>
                </table>

                <% } %>

            <% } %>

        </div>
    </div>

</div>
</body>
</html>