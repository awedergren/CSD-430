<!-- Amanda Wedergren
     November 10, 2025
     Module 5&6 Assignment
-->
     
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.csd430.beans.Movie" %>
<%
/*
  display_movie.jsp
  - Receives movieId from job_select.jsp, queries the DB for the full row,
    populates a Movie JavaBean and displays the values in an HTML table.
  - Uses scriptlets for DB access and bean population per assignment requirements.
  - All HTML tags are outside scriptlets.
*/
String selectedIdStr = request.getParameter("movieId");
if (selectedIdStr == null || selectedIdStr.trim().isEmpty()) {
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>No selection</title>
</head>
<body>
  <h1>No movie selected</h1>
  <p>Please go back and select a movie key.</p>
  <p><a href="job_select.jsp">Back to selection</a></p>
</body>
</html>
<%
} else {
    int movieId = 0;
    try {
        movieId = Integer.parseInt(selectedIdStr);
    } catch (NumberFormatException nfe) {
        movieId = -1;
    }

    // JDBC connection settings
  String jdbcUrl = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    String dbUser = "student1"; // adjust if needed
    String dbPass = "pass";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
        ps = conn.prepareStatement("SELECT id, title, genre, year, director, rating, notes FROM Amanda_movies_data WHERE id = ?");
        ps.setInt(1, movieId);
        rs = ps.executeQuery();

        Movie movie = new Movie();
        if (rs.next()) {
            movie.setId(rs.getInt("id"));
            movie.setTitle(rs.getString("title"));
            movie.setGenre(rs.getString("genre"));
            movie.setYear(rs.getInt("year"));
            movie.setDirector(rs.getString("director"));
            movie.setRating(rs.getDouble("rating"));
            movie.setNotes(rs.getString("notes"));
        }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Movie Record</title>
  <style>
    table { border-collapse: collapse; width: 100%; }
    th, td { padding: 8px; border: 1px solid #ddd; }
    thead { background: #f4f4f4; }
  </style>
</head>
<body>
  <h1>Movie record for key: <%= movie.getId() %></h1>
  <p>This page displays the record fields in a table. Field descriptions are below.</p>

  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Genre</th>
        <th>Year</th>
        <th>Director</th>
        <th>Rating</th>
        <th>Notes</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><%= movie.getId() %></td>
        <td><%= movie.getTitle() %></td>
        <td><%= movie.getGenre() %></td>
        <td><%= movie.getYear() %></td>
        <td><%= movie.getDirector() %></td>
        <td><%= movie.getRating() %></td>
        <td><%= movie.getNotes() %></td>
      </tr>
    </tbody>
  </table>

  <section>
    <h3>Field and recode descriptions</h3>
    <p>The <strong>rating</strong> is a numeric score; recode examples could map rating &gt;= 9.0 to "Excellent", 8.0-8.9 to "Very Good", etc. (not applied here, shown as an example).</p>
  </section>

  <p><a href="job_select.jsp">Back to selection</a></p>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignore) {}
        try { if (ps != null) ps.close(); } catch (Exception ignore) {}
        try { if (conn != null) conn.close(); } catch (Exception ignore) {}
    }
}
%>