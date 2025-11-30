<!-- Amanda Wedergren
     November 24, 2025
     Module 8.2 Assignment
-->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.csd430.beans.Movie" %>
<%
/*
  edit.jsp
  - Loads the selected movie by ID and presents an edit form.
  - ID is displayed read-only and included as hidden input for submission.
*/
String selectedIdStr = request.getParameter("movieId");
String error = null;
Movie movie = null;
if (selectedIdStr == null || selectedIdStr.trim().isEmpty()) {
    error = "No movie id provided.";
} else {
    int movieId = -1;
    try { movieId = Integer.parseInt(selectedIdStr); } catch (Exception ex) { error = "Invalid id."; }
    if (error == null) {
        String jdbcUrl = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String dbUser = "student1"; String dbPass = "pass";
        try (Connection c = null) { }
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
            ps = conn.prepareStatement("SELECT id, title, genre, year, director, rating, notes FROM Amanda_movies_data WHERE id = ?");
            ps.setInt(1, movieId);
            rs = ps.executeQuery();
            if (rs.next()) {
                movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setTitle(rs.getString("title"));
                movie.setGenre(rs.getString("genre"));
                movie.setYear(rs.getInt("year"));
                movie.setDirector(rs.getString("director"));
                movie.setRating(rs.getDouble("rating"));
                movie.setNotes(rs.getString("notes"));
            } else {
                error = "No record found for id=" + movieId;
            }
        } catch (Exception e) { error = e.getMessage(); }
        finally { try { if (rs!=null) rs.close(); } catch(Exception ignore){} try{ if(ps!=null) ps.close(); } catch(Exception ignore){} try{ if(conn!=null) conn.close(); } catch(Exception ignore){} }
    }
}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Movie</title>
  <style>body{font-family:Arial,Helvetica,sans-serif;background:#f4f7fb;color:#222}.card{max-width:800px;margin:30px auto;background:#fff;padding:20px;border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,.06)}label{display:block;margin-top:10px}input[type=text],input[type=number],textarea{width:100%;padding:8px;box-sizing:border-box}button{background:#2e7d32;color:#fff;border:none;padding:10px 14px;border-radius:4px;margin-top:12px}.note{color:#b00}.key{font-weight:bold;background:#eee;padding:8px;border-radius:4px;display:inline-block}</style>
</head>
<body>
<div class="card">
  <h2>Edit Movie</h2>
  <% if (error != null) { %>
    <p class="note"><%= error %></p>
    <p><a href="index.jsp">Back to selection</a></p>
  <% } else { %>
    <form action="update.jsp" method="post">
      <label>ID (key):</label>
      <div class="key"><%= movie.getId() %></div>
      <input type="hidden" name="id" value="<%= movie.getId() %>" />

      <label for="title">Title:</label>
      <input type="text" id="title" name="title" value="<%= movie.getTitle() == null ? "" : movie.getTitle() %>" />

      <label for="genre">Genre:</label>
      <input type="text" id="genre" name="genre" value="<%= movie.getGenre() == null ? "" : movie.getGenre() %>" />

      <label for="year">Year:</label>
      <input type="number" id="year" name="year" value="<%= movie.getYear() %>" />

      <label for="director">Director:</label>
      <input type="text" id="director" name="director" value="<%= movie.getDirector() == null ? "" : movie.getDirector() %>" />

      <label for="rating">Rating:</label>
      <input type="number" step="0.1" id="rating" name="rating" value="<%= movie.getRating() %>" />

      <label for="notes">Notes:</label>
      <textarea id="notes" name="notes"><%= movie.getNotes() == null ? "" : movie.getNotes() %></textarea>

      <button type="submit">Save Changes</button>
    </form>
    <p><a href="index.jsp">Cancel</a></p>
  <% } %>
</div>
</body>
</html>
