<!-- Amanda Wedergren
     November 17, 2025
     Module 7.1 Assignment
-->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
/*
  add_record.jsp
  ----------------
  Purpose:
  - Render an HTML form that collects data for a new movie record and posts it to
    `add_movie.jsp` which performs server-side insertion into the `Amanda_movies_data` table.

  Important implementation notes:
  - This JSP intentionally keeps Java code out of the HTML (no heavy scriptlets). The
    page declares the response content type and encoding at the top so the browser handles
    characters correctly.
  - The `form` uses method="post" to submit user-entered data. POST is used because the
    request has side-effects (writes to the database) and because POST bodies are better
    suited for larger payloads and for avoiding sensitive data in URLs.
  - Client-side validation (HTML attributes like `required`, `type=number`, `min`, `max`)
    is provided to improve UX but must NOT be relied on for security; server-side
    validation is still required in `add_movie.jsp` before inserting into the database.
  - Field names (the `name` attributes) map directly to request parameters in
    `add_movie.jsp` (e.g., `request.getParameter("title")`). Keep these names in sync.
  - The database `id` is assumed to be an auto-increment primary key and is not part
    of the form.

  Security & maintenance reminders:
  - Do not keep production DB credentials in JSP files. Use a DataSource/JNDI or
    environment-based configuration in real applications.
  - Consider adding CSRF protection and stronger server-side validation for any
    production-facing form. Also sanitize output when reflecting user input to avoid
    XSS vulnerabilities.

  This file is intentionally simple for instructional purposes; the heavy lifting (bean
  population, JDBC prepared statements, and result display) is implemented in
  `add_movie.jsp` as part of the assignment.
*/
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Movie Record (Module 6 - Part 2)</title>
  <style>label{display:block;margin-top:8px;} input, textarea{width:100%;max-width:600px;}</style>
</head>
<body>
  <h1>Module 6 — Part 2: Add a movie record</h1>
  <p>Use this form to add a new movie record to the <code>Amanda_movies_data</code> table. The key <strong>id</strong> is generated automatically by the database.</p>

  <!--
    Form details:
    - method="post": sends form data in the request body; appropriate for writes.
    - action="add_movie.jsp": the receiving JSP reads parameters with
      request.getParameter("<name>") and performs insertion into the database.
    - Keep the `name` attributes below in sync with `add_movie.jsp`.
  -->
  <form method="post" action="add_movie.jsp">
    <label for="title">Title</label>
    <!-- title: expected String (required) -->
    <input type="text" id="title" name="title" required />

    <label for="genre">Genre</label>
    <!-- genre: expected String (required) -->
    <input type="text" id="genre" name="genre" required />

    <label for="year">Year</label>
    <!-- year: expected integer (client-side constrained between 1888 and 2100) -->
    <input type="number" id="year" name="year" min="1888" max="2100" required />

    <label for="director">Director</label>
    <!-- director: optional String -->
    <input type="text" id="director" name="director" />

    <label for="rating">Rating (e.g., 8.5)</label>
    <!-- rating: optional numeric value; `step` allows decimal ratings like 8.5 -->
    <input type="number" step="0.1" min="0" max="10" id="rating" name="rating" />

    <label for="notes">Notes</label>
    <!-- notes: optional free-text; will be stored as TEXT/VARCHAR depending on DB schema -->
    <textarea id="notes" name="notes" rows="4"></textarea>

    <button type="submit" style="margin-top:12px;">Add record</button>
  </form>

  <p><a href="movie_select.jsp">Back to selection</a> | <a href="display_all.jsp">View all records</a></p>

  <hr>
  <section>
    <h3>Field descriptions</h3>
    <ul>
      <li><strong>id</strong>: Primary key (auto-increment)</li>
      <li><strong>title</strong>: Movie title (required)</li>
      <li><strong>genre</strong>: Movie genre (required)</li>
      <li><strong>year</strong>: Release year (required)</li>
      <li><strong>director</strong>: Director name</li>
      <li><strong>rating</strong>: Numeric rating 0-10</li>
      <li><strong>notes</strong>: Optional notes</li>
    </ul>
  </section>

</body>
</html>
