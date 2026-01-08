package com.sms.utils;

//Program to establish connection with database mysql
//This allows your entire system to get DB connections easily.
//Creating JDBC Connection Helper Class
	import java.sql.Connection;
	import java.sql.DriverManager;

	public class DBConnection {
	    private static final String URL = 
	        "jdbc:mysql://localhost:3306/student_management_system?useSSL=false&serverTimezone=UTC";

	    private static final String USER = "root";  
	    private static final String PASSWORD = "ssss";

	    public static Connection getConnection() {
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            return DriverManager.getConnection(URL, USER, PASSWORD);
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }
	}

