<%@ page import="com.sms.model.User, java.sql.*, java.util.*, com.sms.utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"STUDENT".equals(u.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    int studentId = -1;
    String studentName = "";

    try (Connection con = DBConnection.getConnection()) {

        // get student_id + name
        PreparedStatement ps = con.prepareStatement(
            "SELECT student_id, name FROM student WHERE user_id=?"
        );
        ps.setInt(1, u.getUserId());
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            studentId = rs.getInt("student_id");
            studentName = rs.getString("name");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Final Results | SKG</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- Brand Bar -->
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

            <h2 class="dashboard-title">Final Results</h2>
            <p class="dashboard-subtitle">
                CIE (50) + SEE (50) → Total (100) → Grade
            </p>

            <table class="data-table">
                <tr>
                    <th>Course Code</th>
                    <th>CIE (50)</th>
                    <th>SEE (50)</th>
                    <th>Total</th>
                    <th>Grade</th>
                    <th>Grade Points</th>
                </tr>

                <%
                    boolean hasData = false;

                    try (Connection con = DBConnection.getConnection()) {

                        String sql =
                            "SELECT course_code, cie_score, see_score, total_score, grade_letter, grade_points " +
                            "FROM final_grade WHERE student_id=? ORDER BY course_code";

                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setInt(1, studentId);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            hasData = true;
                %>
                <tr>
                    <td><%= rs.getString("course_code") %></td>
                    <td><%= rs.getInt("cie_score") %></td>
                    <td><%= rs.getInt("see_score") %></td>
                    <td><%= rs.getInt("total_score") %></td>
                    <td><%= rs.getString("grade_letter") %></td>
                    <td><%= rs.getInt("grade_points") %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (!hasData) {
                %>
                <tr>
                    <td colspan="6" style="text-align:center;">
                        Final results not published yet.
                    </td>
                </tr>
                <% } %>

            </table>

        </div>
    </div>
</div>
</body>
</html>