package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.sms.utils.DBConnection;

public class TeacherCourseDAO {

    public boolean assignCourseToTeacher(int teacherId, int courseId) {

        String sql = "INSERT INTO teacher_course(teacher_id, course_id) VALUES(?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);
            ps.setInt(2, courseId);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();   // duplicate = already assigned
        }

        return false;
    }
}