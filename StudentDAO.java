package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.Student;
import com.sms.utils.DBConnection;

public class StudentDAO {

    // ------- ADD STUDENT (NO CHANGE) -------
    public boolean addStudent(String name, String usn, int deptId, int sem, String password) {

        Connection con = DBConnection.getConnection();

        try {
            con.setAutoCommit(false);

            String userSql = "INSERT INTO users(username, password_hash, role) VALUES(?, ?, 'STUDENT')";
            PreparedStatement ps1 = con.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);

            ps1.setString(1, usn);
            ps1.setString(2, password);
            ps1.executeUpdate();

            ResultSet rs1 = ps1.getGeneratedKeys();
            rs1.next();
            int userId = rs1.getInt(1);

            String stuSql = "INSERT INTO student(user_id, name, usn, department_id, semester) VALUES(?,?,?,?,?)";

            PreparedStatement ps2 = con.prepareStatement(stuSql);

            ps2.setInt(1, userId);
            ps2.setString(2, name);
            ps2.setString(3, usn);
            ps2.setInt(4, deptId);
            ps2.setInt(5, sem);

            ps2.executeUpdate();

            con.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try { con.rollback(); } catch (Exception ignore) {}
        }

        return false;
    }

    // ------- GET ALL STUDENTS (for dropdown / view students) -------
    public List<Student> getAllStudents() {

        List<Student> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT student_id, name, usn, department_id, semester FROM student";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();
                s.setStudentId(rs.getInt("student_id"));
                s.setName(rs.getString("name"));
                s.setUsn(rs.getString("usn"));
                s.setDepartmentId(rs.getInt("department_id"));
                s.setSemester(rs.getInt("semester"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}