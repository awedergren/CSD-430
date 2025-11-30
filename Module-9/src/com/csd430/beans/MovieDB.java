/**
 * Amanda Wedergren
 * November 24, 2025
 * Module 9.2 Assignment
 */

package com.csd430.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * MovieDB JavaBean - provides simple JDBC access used by Module-9 JSPs.
 * <p>
 * This class intentionally holds editable DB connection constants near the top
 * so you can change them to match your environment (database name, user,
 * password, and JDBC driver). All access methods return plain POJOs (the
 * existing `Movie` bean in the same package).
 * <p>
 * Note: compile this class and place the resulting `.class` files under
 * `WEB-INF/classes/com/csd430/beans/` before deploying, or build with your IDE.
 */
public class MovieDB {

    // ------- EDIT THESE TO MATCH YOUR ENVIRONMENT -------
        // ------- EDIT THESE TO MATCH YOUR ENVIRONMENT -------
        // Database used by Module-6: CSD430, user 'student1' with password 'pass'
        // If you have a different setup, change these values to match your environment.
        public static final String JDBC_URL = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        public static final String JDBC_USER = "student1";
        public static final String JDBC_PASSWORD = "pass";
        // ---------------------------------------------------

    // JDBC driver class name (MySQL example). Change if you use a different DB.
    public static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    public MovieDB() {
        /*
         * Load the JDBC driver class. This is a one-time action required by some
         * older JDBC drivers; modern drivers typically register themselves, but
         * loading explicitly keeps the behaviour deterministic across
         * environments. If the driver class is not available on the classpath
         * (for example, the MySQL Connector/J JAR is not in Tomcat's `lib` or
         * webapp `WEB-INF/lib`) this will throw and the application will fail
         * fast with a descriptive message.
         */
        try {
            Class.forName(JDBC_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("JDBC Driver not found: " + JDBC_DRIVER, e);
        }
    }

    /**
     * Retrieve all movies from the table.
     * @return list of Movie beans (may be empty)
     */
    public List<Movie> getAllMovies() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT id, title, genre, year, director, rating, notes FROM Amanda_movies_data ORDER BY id";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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

        } catch (SQLException e) {
            /*
             * Wrap SQLExceptions in a RuntimeException so JSP scriptlets can
             * surface the error to the page during development. In production
             * you would typically log the error and return an empty list or a
             * custom error object rather than throwing.
             */
            throw new RuntimeException("Database error retrieving movies", e);
        }

        return list;
    }

    /**
     * Delete a movie by id.
     * @param id primary key to delete
     * @return true if a row was deleted
     */
    public boolean deleteById(int id) {
        String sql = "DELETE FROM Amanda_movies_data WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            int updated = ps.executeUpdate();
            return updated > 0;

        } catch (SQLException e) {
            /*
             * Deletion errors are surfaced as runtime exceptions here for
             * simplicity. A more robust implementation would map SQL error
             * codes to user-friendly messages and avoid revealing SQL state
             * to end users.
             */
            throw new RuntimeException("Database error deleting id=" + id, e);
        }
    }
}
