package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.Student;
import com.sms.utils.DBConnection;

public class TeacherStudentsDAO {

    // Get teacher_id using username (teacher_code)
    public int getTeacherIdByUsername(String username) {
        String sql = "SELECT teacher_id FROM teacher WHERE teacher_code = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("teacher_id");
            }

        } catch (Exception e) { e.printStackTrace(); }

        return -1;
    }

    public List<Integer> getCoursesForTeacher(int teacherId) {
        List<Integer> list = new ArrayList<>();

        String sql = "SELECT course_id FROM teacher_course WHERE teacher_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getInt("course_id"));
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    public List<Student> getStudentsForCourse(int courseId) {
        List<Student> students = new ArrayList<>();

        String sql =
            "SELECT s.student_id, s.name, s.usn, s.department_id, s.semester " +
            "FROM student s " +
            "JOIN student_course sc ON s.student_id = sc.student_id " +
            "WHERE sc.course_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();
                s.setStudentId(rs.getInt("student_id"));
                s.setName(rs.getString("name"));
                s.setUsn(rs.getString("usn"));
                s.setDepartmentId(rs.getInt("department_id"));
                s.setSemester(rs.getInt("semester"));
                students.add(s);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return students;
    }
    
    
    
    //FOR ENTER IA MARKS MODULE IN TEACHER'S DASHBOARD
    
    public List<String> getAssignedCourseCodes(int teacherId) {
        List<String> list = new ArrayList<>();

        String sql =
            "SELECT c.course_code FROM teacher_course tc " +
            "JOIN course c ON tc.course_id = c.course_id " +
            "WHERE tc.teacher_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString("course_code"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    
    public List<Student> getStudentsForCourseCode(String courseCode) {
        List<Student> studs = new ArrayList<>();

        String sql =
            "SELECT s.student_id, s.name, s.usn, s.department_id, s.semester " +
            "FROM student s " +
            "JOIN student_course sc ON s.student_id = sc.student_id " +
            "JOIN course c ON sc.course_id = c.course_id " +
            "WHERE c.course_code = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, courseCode);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();
                s.setStudentId(rs.getInt("student_id"));
                s.setName(rs.getString("name"));
                s.setUsn(rs.getString("usn"));
                s.setDepartmentId(rs.getInt("department_id"));
                s.setSemester(rs.getInt("semester"));
                studs.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return studs;
    }
    
    public int getTeacherId(int userId) {
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT teacher_id FROM teacher WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("teacher_id");
        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }
    
    
    
    
    public List<Map<String, Object>> getCoursesWithCodes(int teacherId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql =
            "SELECT c.course_id, c.course_code " +
            "FROM teacher_course tc " +
            "JOIN course c ON tc.course_id = c.course_id " +
            "WHERE tc.teacher_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("course_id", rs.getInt("course_id"));
                row.put("course_code", rs.getString("course_code"));
                list.add(row);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }
    
    
    
    public String getCourseCodeById(int courseId) {
        String code = null;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT course_code FROM course WHERE course_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) code = rs.getString("course_code");
        } catch (Exception e) { e.printStackTrace(); }
        return code;
    }
}