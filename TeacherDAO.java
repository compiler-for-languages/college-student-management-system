package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.Teacher;
import com.sms.utils.DBConnection;

public class TeacherDAO {

    // ------- ADD TEACHER (NO CHANGE) -------
    public boolean addTeacher(String name, String tid, int deptId, String password) {

        Connection con = DBConnection.getConnection();

        try {
            con.setAutoCommit(false);

            String userSql = "INSERT INTO users(username, password_hash, role) VALUES(?, ?, 'TEACHER')";
            PreparedStatement ps1 = con.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);

            ps1.setString(1, tid);
            ps1.setString(2, password);
            ps1.executeUpdate();

            ResultSet rs1 = ps1.getGeneratedKeys();
            rs1.next();
            int userId = rs1.getInt(1);

            String sql =
                "INSERT INTO teacher(user_id, name, teacher_code, department_id) VALUES(?,?,?,?)";

            PreparedStatement ps2 = con.prepareStatement(sql);

            ps2.setInt(1, userId);
            ps2.setString(2, name);
            ps2.setString(3, tid);
            ps2.setInt(4, deptId);

            ps2.executeUpdate();

            con.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try { con.rollback(); } catch (Exception ignore) {}
        }

        return false;
    }

    // ------- GET ALL TEACHERS (for dropdown / view teachers) -------
    public List<Teacher> getAllTeachers() {

        List<Teacher> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT teacher_id, name, teacher_code, department_id FROM teacher";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Teacher t = new Teacher();
                t.setTeacherId(rs.getInt("teacher_id"));
                t.setName(rs.getString("name"));
                t.setTeacherCode(rs.getString("teacher_code"));
                t.setDepartmentId(rs.getInt("department_id"));

                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    
    public String getTeacherNameByUserId(int userId) {
        String name = "";
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT name FROM teacher WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }
}