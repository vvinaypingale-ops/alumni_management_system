package com.alumni.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Read from environment variables if present, fallback to local values
        String url = System.getenv("MYSQL_URL");
        if (url == null || url.isEmpty()) {
            url = "jdbc:mysql://localhost:3306/alumni_db?useSSL=false&serverTimezone=UTC";
        }
        
        String user = System.getenv("MYSQL_USER");
        if (user == null || user.isEmpty()) {
            user = "root";
        }
        
        String password = System.getenv("MYSQL_PASSWORD");
        if (password == null || password.isEmpty()) {
            password = "root";
        }

        // Load the MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
}
