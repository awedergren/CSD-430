<!-- Amanda Wedergren
     November 17, 2025
     Module 7.1 Assignment
-->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
/*
  index.jsp
  ---------

  What this page contains and why:
  - Minimal server-side code: only a page directive to set the response content type and
    encoding. The remainder is static HTML used for navigation and simple instructions.
  - Links:
    * movie_select.jsp - a page that presents a selection (e.g., dropdown) of existing movies
      (useful to demonstrate request/response and bean population).
    * add_record.jsp - form to add a new movie (posts to add_movie.jsp which performs DB insert).
    * display_all.jsp - displays all records by querying the database and rendering a table.

  Deployment and maintenance notes:
  - Ensure the MySQL Connector/J driver (JAR) is available either in Tomcat's global
    lib folder or the webapp's WEB-INF/lib so JDBC calls work in the other JSPs.
  - The `Movie` JavaBean should be compiled and available under WEB-INF/classes or in a
    packaged WAR with the correct package structure (com.csd430.beans.Movie).
  - This file intentionally avoids business logic; keep it as a navigation hub only.

  Security & guidance:
  - Although this page is static, the linked JSPs perform DB operations; follow
    best-practices there (use PreparedStatement, sanitize output, avoid embedding
    credentials directly in JSPs for production).
*/
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Module-6 — Movie Records (Module 6, Part 2)</title>
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.4; margin: 24px; }
    main { max-width: 900px; }
    ul { line-height: 1.6 }
  </style>
</head>
<body>
  <main>
    <h1>Module 6 — Movie Records (Part 2)</h1>
    <p>Use these pages to select, add, and view movie records in the <code>CSD430</code> database. This module continues from Module-5/6 and uses the same <code>Amanda_movies_data</code> table and <code>Movie</code> JavaBean.</p>

    <h2>Quick links</h2>
    <ul>
      <li><a href="movie_select.jsp">Select a movie (dropdown)</a></li>
      <li><a href="add_record.jsp">Add a new movie record</a></li>
      <li><a href="display_all.jsp">View all movie records</a></li>
    </ul>

    <h2>Notes</h2>
    <p>The JSPs use scriptlets for DB access (assignment requirement). Ensure MySQL Connector/J is available in Tomcat's <code>lib</code> or the webapp's <code>WEB-INF/lib</code>, and compile the JavaBean into <code>WEB-INF/classes</code> before deployment.</p>
  </main>
</body>
</html>
