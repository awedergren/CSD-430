<!-- Amanda Wedergren
     November 24, 2025
     Module 8.2 Assignment
-->


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
/*
  job_select.jsp
  - Connects to the CSD430 database and queries the key values for the dropdown.
  - Uses Scriptlets per assignment requirement. All HTML tags are outside scriptlets.
  - The dropdown lists the primary keys (id) and shows the movie title next to each key.
  - When submitted, the form posts the selected key to display_movie.jsp which will use a JavaBean to display the full record.

  Notes:
  - Edit the DB connection below if your JDBC settings differ.
  - Ensure the JDBC driver (MySQL Connector/J) is available to Tomcat (WEB-INF/lib) or server classpath.
*/
String jdbcUrl = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
String dbUser = "student1"; // change if different
String dbPass = "pass";    // change if different

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
  <title>Select Movie (Module 6)</title>
</head>
<body>
  <h1>Module 6: Select a movie record</h1>
  <p>Choose a key (id) from the dropdown and submit to view the full record.</p>

  <form method="post" action="display_movie.jsp">
    <label for="movieId">Select movie:</label>
    <select name="movieId" id="movieId">
      <option value="">-- Select a key --</option>
<%
    while (rs.next()) {
        int id = rs.getInt("id");
        String title = rs.getString("title");
%>
      <option value="<%=id%>"><%= id %> - <%= title %></option>
<%
    }
%>
    </select>
    <button type="submit">Show record</button>
  </form>

  <hr>
  <section>
    <h3>Field descriptions</h3>
    <ul>
      <li><strong>id</strong>: Primary key (INT)</li>
      <li><strong>title</strong>: Movie title</li>
      <li><strong>genre</strong>: Movie genre</li>
      <li><strong>year</strong>: Release year</li>
      <li><strong>director</strong>: Director name</li>
      <li><strong>rating</strong>: Numeric rating (1-10)</li>
      <li><strong>notes</strong>: Free text</li>
    </ul>
  </section>

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
