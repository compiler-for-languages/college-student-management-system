package com.sms.dao;

import java.sql.*;
import com.sms.utils.DBConnection;
import com.sms.model.User;

public class UserDAO {

    public User validateUser(String username, String password, String role) {
        User user = null;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT user_id, username, role FROM users WHERE username=? AND password_hash=? AND role=?";
                          
            PreparedStatement ps = con.prepareStatement(sql); 

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}