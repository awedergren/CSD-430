<!-- Amanda Wedergren
     November 17, 2025
     Module 7.1 Assignment
-->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
/*
  display_all.jsp
  ----------------
  Purpose:
  - Connect to the MySQL `CSD430` database and query the `Amanda_movies_data` table.
  - Render all rows as an HTML table so users can view every movie record.

  Implementation notes & guidance:
  - This file uses JSP scriptlets to perform JDBC operations directly. In production,
    prefer a servlet or MVC controller that populates a request attribute and uses a JSP
    only for rendering to separate concerns.
  - Connection details (URL, user, password) are hard-coded for the assignment. Move
    them to a DataSource/JNDI or secure configuration in real applications.
  - The query is executed with a PreparedStatement even though there are no parameters.
    Using PreparedStatement is still fine and consistent; it also avoids SQL injection
    if parameters are later added.
  - The ResultSet is iterated with rs.next() and each column is printed using
    expression tags like &lt;%= rs.getString("title") %&gt;. Be careful: output should be
    escaped/sanitized to avoid XSS if any field contains user-supplied HTML.
  - JDBC resources (ResultSet, PreparedStatement, Connection) are closed in a finally
    block; each close is wrapped in a try/catch to ensure best-effort cleanup.

  UX & performance notes:
  - For large tables, pagination should be implemented instead of selecting all rows.
  - Consider SELECTing only columns needed for display or limiting rows using
    ORDER BY / LIMIT for better performance.
*/
String jdbcUrl = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
String dbUser = "student1";
String dbPass = "pass";

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    // Load the JDBC driver (modern drivers auto-register, but this remains explicit)
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Establish a connection to the DB using the configured URL and credentials.
    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

    // Prepare the SELECT query. ORDER BY id provides stable ordering.
    ps = conn.prepareStatement("SELECT id, title, genre, year, director, rating, notes FROM Amanda_movies_data ORDER BY id");

    // Execute the query and obtain a ResultSet to iterate over rows.
    rs = ps.executeQuery();
} catch (Exception e) {
    // Print a simple error message to the page if the query fails.
    out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>All Movie Records</title>
  <style>table{border-collapse:collapse;width:100%}th,td{padding:8px;border:1px solid #ddd}thead{background:#f4f4f4}</style>
</head>
<body>
  <h1>All movie records</h1>

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
    <%
      try {
        // Iterate through each row of the ResultSet and render a table row for it.
        // The checks (rs != null && rs.next()) protect against null ResultSet
        // when an earlier error prevented the query from being assigned.
        while (rs != null && rs.next()) {
    %>
      <tr>
        <!-- Use column names for clarity and to avoid index-shift bugs -->
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("genre") %></td>
        <td><%= rs.getInt("year") %></td>
        <td><%= rs.getString("director") %></td>
        <td><%= rs.getDouble("rating") %></td>
        <td><%= rs.getString("notes") %></td>
      </tr>
    <%
        }
      } catch (Exception e) {
        // If iteration fails, render a single-row error message inside the table body
        out.println("<tr><td colspan='7' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
      } finally {
        // Close JDBC resources in reverse order of allocation. Each close is guarded
        // with a try/catch so that one failing close does not prevent others from
        // executing.
        try { if (rs != null) rs.close(); } catch (Exception ignore) {}
        try { if (ps != null) ps.close(); } catch (Exception ignore) {}
        try { if (conn != null) conn.close(); } catch (Exception ignore) {}
      }
    %>
    </tbody>
  </table>

  <p><a href="add_record.jsp">Add new record</a> | <a href="movie_select.jsp">Select</a></p>
</body>
</html>
