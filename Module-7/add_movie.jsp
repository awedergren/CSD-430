<!-- Amanda Wedergren
     November 17, 2025
     Module 7.1 Assignment
-->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
/*
  add_movie.jsp
  ----------------
  Purpose:
  - Receive form input (POST) from `add_record.jsp`.
  - Parse input parameters, validate/parse primitive types where necessary.
  - Populate a `Movie` bean instance with the submitted values.
  - Insert the new movie into the database using a prepared statement (prevents SQL injection).
  - Query all records from the table and display them in an HTML table.

  Notes and maintenance pointers:
  - This page uses JSP scriptlets (Java code embedded in the JSP). In modern apps consider
    using MVC with servlets or frameworks (JSP scriptlets are discouraged for large apps).
  - Database credentials are hard-coded here for the assignment. In production move them
    to a secure config (JNDI/DataSource, encrypted config, or environment variables).
  - Prepared statements are used for the INSERT to avoid SQL injection and to handle
    parameter binding safely.
  - All JDBC resources (ResultSet, PreparedStatement, Connection) are closed in `finally`.
  - Basic parsing is performed for numeric fields (year, rating). Invalid numbers fall
    back to default values (0 and 0.0 respectively).
*/
String jdbcUrl = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
String dbUser = "student1";
String dbPass = "pass";

// Read parameters from form
String title = request.getParameter("title");
String genre = request.getParameter("genre");
String yearStr = request.getParameter("year");
String director = request.getParameter("director");
String ratingStr = request.getParameter("rating");
String notes = request.getParameter("notes");

int year = 0;
double rating = 0.0;
try { year = Integer.parseInt(yearStr); } catch (Exception e) { year = 0; }
try { rating = Double.parseDouble(ratingStr); } catch (Exception e) { rating = 0.0; }

// We don't depend on a JavaBean class being present in the webapp for this
// assignment run. Use local variables (title, genre, year, director, rating,
// notes) directly when binding parameters below.

Connection conn = null;
PreparedStatement psInsert = null;
PreparedStatement psSelect = null;
ResultSet rs = null;
String insertSql = "INSERT INTO Amanda_movies_data (title, genre, year, director, rating, notes) VALUES (?, ?, ?, ?, ?, ?)";
String selectSql = "SELECT id, title, genre, year, director, rating, notes FROM Amanda_movies_data ORDER BY id";

String message = "";
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
  // Prepare and execute the INSERT using a PreparedStatement. Using placeholders (?)
  // ensures type-safe binding and avoids SQL injection vulnerabilities.
  psInsert = conn.prepareStatement(insertSql);
  // Bind request-derived variables directly (no bean required in the webapp)
  psInsert.setString(1, title);     // title -> VARCHAR
  psInsert.setString(2, genre);     // genre -> VARCHAR
  psInsert.setInt(3, year);         // year -> INT (defaults to 0 on parse error)
  psInsert.setString(4, director);  // director -> VARCHAR
  psInsert.setDouble(5, rating);    // rating -> DOUBLE (defaults to 0.0 on parse error)
  psInsert.setString(6, notes);     // notes -> TEXT/VARCHAR

  // Execute the INSERT; executeUpdate returns number of rows affected.
  int inserted = psInsert.executeUpdate();
  message = inserted + " row(s) inserted.";

  // After inserting, retrieve all rows to display the current state of the table.
  psSelect = conn.prepareStatement(selectSql);
  rs = psSelect.executeQuery();
} catch (Exception e) {
    message = "Error: " + e.getMessage();
}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Added Movie - All Records</title>
  <style>table{border-collapse:collapse;width:100%}th,td{padding:8px;border:1px solid #ddd}thead{background:#f4f4f4}</style>
</head>
<body>
  <h1>All movie records (after insert)</h1>
  <p><strong>Status:</strong> <%= message %></p>

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
    while (rs != null && rs.next()) {
%>
      <tr>
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
    out.println("<tr><td colspan='7' style='color:red'>Error reading records: " + e.getMessage() + "</td></tr>");
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignore) {}
    try { if (psInsert != null) psInsert.close(); } catch (Exception ignore) {}
    try { if (psSelect != null) psSelect.close(); } catch (Exception ignore) {}
    try { if (conn != null) conn.close(); } catch (Exception ignore) {}
}
%>
    </tbody>
  </table>

  <p><a href="add_record.jsp">Add another</a> | <a href="movie_select.jsp">Select</a></p>

  <section>
    <h3>Field & recode descriptions</h3>
    <p>The <strong>rating</strong> is numeric. Example recode: rating &gt;= 9 => Excellent; 8-8.9 => Very Good.</p>
  </section>
</body>
</html>
