<%@ page import="java.util.*, java.sql.*, com.sms.model.User, com.sms.utils.DBConnection" %>
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

        // get student_id + name using user_id
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

    List<Map<String,Object>> marks = new ArrayList<>();

    if (studentId != -1) {
        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "SELECT course_code, ia1, ia2, ia3, cta " +
                "FROM internal_marks " +
                "WHERE student_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String,Object> row = new HashMap<>();
                int ia1 = rs.getInt("ia1");
                int ia2 = rs.getInt("ia2");
                int ia3 = rs.getInt("ia3");

                int[] arr = { ia1, ia2, ia3 };
                Arrays.sort(arr);
                int bestTwo = arr[1] + arr[2];

                row.put("course", rs.getString("course_code"));
                row.put("ia1", ia1);
                row.put("ia2", ia2);
                row.put("ia3", ia3);
                row.put("cta", rs.getInt("cta"));
                row.put("best", bestTwo);

                marks.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IA Marks | Student</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="bg">

    <!-- Brand bar -->
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

            <h2 class="dashboard-title">IA Marks</h2>
            <p class="dashboard-subtitle">
                IA-1, IA-2, IA-3 and Best of Two (40)
            </p>

            <% if (marks.isEmpty()) { %>
                <p>No IA marks available yet.</p>
            <% } else { %>

            <table class="data-table">
                <tr>
                    <th>Course</th>
                    <th>IA-1</th>
                    <th>IA-2</th>
                    <th>IA-3</th>
                    <th>Best 2 (40)</th>
                    <th>CTA (10)</th>
                </tr>

                <% for (Map<String,Object> m : marks) { %>
                <tr>
                    <td><%= m.get("course") %></td>
                    <td><%= m.get("ia1") %></td>
                    <td><%= m.get("ia2") %></td>
                    <td><%= m.get("ia3") %></td>
                    <td><%= m.get("best") %></td>
                    <td><%= m.get("cta") %></td>
                </tr>
                <% } %>
            </table>

            <% } %>

        </div>
    </div>
</div>
</body>
</html>