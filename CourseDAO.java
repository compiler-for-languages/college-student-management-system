package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.Course;
import com.sms.utils.DBConnection;

public class CourseDAO {

    public boolean addCourse(String code, String name, int semester, int credits, String department) {
        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO course(course_code, course_name, credits, semester, department) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, code);
            ps.setString(2, name);
            ps.setInt(3, credits);
            ps.setInt(4, semester);
            ps.setString(5, department);

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    // ⭐ VIEW COURSES — Fetch all courses
    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM course ORDER BY semester, department, course_code";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();
                c.setCourseId(rs.getInt("course_id"));
                c.setCourseCode(rs.getString("course_code"));
                c.setCourseName(rs.getString("course_name"));
                c.setCredits(rs.getInt("credits"));
                c.setSemester(rs.getInt("semester"));
                c.setDepartment(rs.getString("department"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}