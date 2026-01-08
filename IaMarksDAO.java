package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.utils.DBConnection;
import com.sms.model.IaMark;



public class IaMarksDAO {

	public List<IaMark> getMarksForTeacher(int teacherId) {
	    List<IaMark> list = new ArrayList<>();

	    String sql =
	        "SELECT im.course_code, im.student_id, s.name, s.usn, " +
	        "       im.ia1, im.ia2, im.ia3, im.cta " +
	        "FROM internal_marks im " +
	        "JOIN student s        ON im.student_id = s.student_id " +
	        "JOIN course c         ON im.course_code = c.course_code " +
	        "JOIN teacher_course tc ON tc.course_id = c.course_id " +
	        "WHERE tc.teacher_id = ?";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, teacherId);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            IaMark m = new IaMark();

	            m.setCourseCode(rs.getString("course_code"));
	            m.setStudentId(rs.getInt("student_id"));
	            m.setStudentName(rs.getString("name"));
	            m.setUsn(rs.getString("usn"));
	            m.setIa1(rs.getInt("ia1"));
	            m.setIa2(rs.getInt("ia2"));
	            m.setIa3(rs.getInt("ia3"));
	            m.setCta(rs.getInt("cta"));

	            list.add(m);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
}