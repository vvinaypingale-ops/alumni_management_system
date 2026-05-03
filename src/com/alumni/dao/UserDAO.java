package com.alumni.dao;

import com.alumni.model.User;
import com.alumni.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User authenticate(String username, String password) {
        String sql = "SELECT id, username, role FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password); // Note: In production, hash the password before comparing!

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("role")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean registerUser(User user, com.alumni.model.Alumni alumni) {
        String insertUserSql = "INSERT INTO users (username, password, role) VALUES (?, ?, 'ALUMNI')";
        String insertAlumniSql = "INSERT INTO alumni (user_id, first_name, last_name, graduation_year, degree) VALUES (?, ?, ?, ?, ?)";
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start Transaction

            int userId = -1;
            // 1. Insert User
            try (PreparedStatement stmtUser = conn.prepareStatement(insertUserSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmtUser.setString(1, user.getUsername());
                stmtUser.setString(2, user.getPassword());
                int affectedRows = stmtUser.executeUpdate();

                if (affectedRows == 0) {
                    throw new SQLException("Creating user failed, no rows affected.");
                }

                try (ResultSet generatedKeys = stmtUser.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        userId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Creating user failed, no ID obtained.");
                    }
                }
            }

            // 2. Insert Alumni Profile
            try (PreparedStatement stmtAlumni = conn.prepareStatement(insertAlumniSql)) {
                stmtAlumni.setInt(1, userId);
                stmtAlumni.setString(2, alumni.getFirstName());
                stmtAlumni.setString(3, alumni.getLastName());
                stmtAlumni.setInt(4, alumni.getGraduationYear());
                stmtAlumni.setString(5, alumni.getDegree());
                stmtAlumni.executeUpdate();
            }

            conn.commit(); // Commit Transaction
            return true;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback Transaction on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }
}
