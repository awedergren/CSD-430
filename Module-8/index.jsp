<!-- Amanda Wedergren
     November 24, 2025
     Module 8.2 Assignment
-->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
/*
  index.jsp (movie selection)
  - Lists movie primary keys with titles in a dropdown.
  - Posts selected id to `edit.jsp` which shows the editable form.
  - Uses scriptlets per assignment requirement; HTML remains outside scriptlets.
*/
String jdbcUrl = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
String dbUser = "student1";
String dbPass = "pass";

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
    ps = conn.prepareStatement("SELECT id, title FROM Amanda_movies_data ORDER BY id");
    rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Select Movie (Module 8)</title>
  <style>body{font-family:Arial,Helvetica,sans-serif;background:#f7f9fc;color:#222}.card{max-width:720px;margin:28px auto;background:#fff;padding:18px;border-radius:8px;box-shadow:0 2px 8px rgba(0,0,0,.06)}label,select,button{display:block;margin-top:8px}button{margin-top:12px;padding:8px 12px;background:#1976d2;color:#fff;border:none;border-radius:4px}</style>
</head>
<body>
  <div class="card">
    <h1>Select a movie to edit</h1>
    <form method="post" action="edit.jsp">
      <label for="movieId">Select movie:</label>
      <select name="movieId" id="movieId">
        <option value="">-- Select a key --</option>
        <% while (rs.next()) { int id = rs.getInt("id"); String title = rs.getString("title"); %>
          <option value="<%=id%>"><%= id %> - <%= title %></option>
        <% } %>
      </select>
      <button type="submit">Edit selected movie</button>
    </form>

    <hr />
    <section>
      <h3>Field descriptions</h3>
      <ul>
        <li><strong>id</strong>: Primary key (INT)</li>
        <li><strong>title</strong>: Movie title</li>
        <li><strong>genre</strong>: Movie genre</li>
        <li><strong>year</strong>: Release year</li>
        <li><strong>director</strong>: Director name</li>
        <li><strong>rating</strong>: Numeric rating</li>
        <li><strong>notes</strong>: Free text</li>
      </ul>
    </section>
  </div>
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
%>
