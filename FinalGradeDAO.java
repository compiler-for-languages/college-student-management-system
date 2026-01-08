package com.sms.dao;

import com.sms.model.FinalGrade;
import com.sms.utils.DBConnection;
import java.sql.*;

public class FinalGradeDAO {

    // upsert final grade
    public void upsertFinalGrade(FinalGrade fg) throws Exception {
        String sql = "INSERT INTO final_grade(student_id, course_code, cie_score, see_score, total_score, grade_letter, grade_points) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE cie_score=?, see_score=?, total_score=?, grade_letter=?, grade_points=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, fg.getStudentId());
            ps.setString(2, fg.getCourseCode());
            ps.setInt(3, fg.getCieScore());
            ps.setInt(4, fg.getSeeScore());
            ps.setInt(5, fg.getTotalScore());
            ps.setString(6, fg.getGradeLetter());
            ps.setInt(7, fg.getGradePoints());

            // update part
            ps.setInt(8, fg.getCieScore());
            ps.setInt(9, fg.getSeeScore());
            ps.setInt(10, fg.getTotalScore());
            ps.setString(11, fg.getGradeLetter());
            ps.setInt(12, fg.getGradePoints());

            ps.executeUpdate();
        }
    }
}