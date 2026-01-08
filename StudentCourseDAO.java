package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.sms.utils.DBConnection;

public class StudentCourseDAO {

    public boolean assignCourseToStudent(int studentId, int courseId) {

        String sql = "INSERT INTO student_course(student_id, course_id) VALUES(?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();   // duplicate = already enrolled
        }

        return false;
    }
}