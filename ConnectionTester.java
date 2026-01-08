package com.sms.utils;
import java.sql.*;
public class ConnectionTester {
	public static void main(String[] args) throws Exception {
	    Connection con = DBConnection.getConnection();
	    System.out.println("Connected to student_management_system database successfully: " + con);
	}

}
