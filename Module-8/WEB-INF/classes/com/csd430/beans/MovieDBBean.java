package com.csd430.beans;

import java.sql.*;
import java.util.*;
import java.io.InputStream;

/**
 * JavaBean responsible for database access to the Amanda_movies_data table.
 *
 * Notes:
 * - This bean reads DB connection settings from `db.properties` on the classpath.
 * - It provides simple methods to list movies and delete by id. JSPs use
 *   scriptlets to call these methods as required by the assignment.
 */
public class MovieDBBean {
    private String url;
    private String user;
    private String password;

    public MovieDBBean() {
        try {
            Properties p = new Properties();
            InputStream in = getClass().getClassLoader().getResourceAsStream("db.properties");
            if (in != null) {
                p.load(in);
                url = p.getProperty("url");
                user = p.getProperty("user");
                password = p.getProperty("password");
            } else {
                // Fallback: common default used in this project
                url = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true";
                user = "student1";
                password = "pass";
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load DB properties", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }

    /**
     * Return all movies as a List of Movie beans.
     */
    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT id, title, genre, year, director, rating, notes FROM Amanda_movies_data ORDER BY id";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Movie m = new Movie();
                m.setId(rs.getInt("id"));
                m.setTitle(rs.getString("title"));
                m.setGenre(rs.getString("genre"));
                m.setYear(rs.getInt("year"));
                m.setDirector(rs.getString("director"));
                m.setRating(rs.getDouble("rating"));
                m.setNotes(rs.getString("notes"));
                list.add(m);
            }
        }
        return list;
    }

    /**
     * Delete a movie by id. Returns rows affected.
     */
    public int deleteById(int id) throws SQLException {
        String sql = "DELETE FROM Amanda_movies_data WHERE id = ?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate();
        }
    }

    /**
     * Return all remaining ids in ascending order.
     */
    public List<Integer> getAllIds() throws SQLException {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT id FROM Amanda_movies_data ORDER BY id";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) ids.add(rs.getInt("id"));
        }
        return ids;
    }
}
