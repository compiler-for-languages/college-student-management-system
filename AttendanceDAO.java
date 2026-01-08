package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.utils.DBConnection;

public class AttendanceDAO {

    public List<Map<String, Object>> getAttendance(String courseCode, String date) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql =
            "SELECT a.student_id, s.name, s.usn, a.status " +
            "FROM attendance a " +
            "JOIN student s ON a.student_id = s.student_id " +
            "WHERE a.course_code = ? AND a.attendance_date = ? " +
            "ORDER BY s.usn";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, courseCode);
            ps.setDate(2, java.sql.Date.valueOf(date));

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("student_id", rs.getInt("student_id"));
                row.put("name", rs.getString("name"));
                row.put("usn", rs.getString("usn"));
                row.put("status", rs.getString("status"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}