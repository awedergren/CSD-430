<!-- Amanda Wedergren
     November 24, 2025
     Module 9.2 Assignment
-->

<%--
    Module-9 list.jsp
    -----------------
    Purpose: Display all rows from the `Amanda_movies_data` table and provide
    a simple delete-by-id form. The assignment requires using scriptlets for
    server-side logic; all HTML markup remains outside of scriptlet blocks.

    Implementation notes:
    - `com.csd430.beans.MovieDB` is used as the JavaBean responsible for all
        database access (retrieving rows and deleting by id).
    - The page accepts a `deleteId` GET parameter when the delete form is
        submitted. After deletion the page reloads and the updated row list is
        shown immediately.
    - For clarity and to avoid JSP import issues, fully-qualified class names
        are used in scriptlets (e.g. `com.csd430.beans.Movie`).
--%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Movie Delete Form</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; }
        th { background: #eee; }
        .message { margin: 10px 0; color: #006600; }
    </style>
</head>
<body>
<h1>Movie Records</h1>
<p>This page displays all records from the <code>Amanda_movies_data</code> table
   and provides a dropdown to select a record to delete. Data access is handled
   by the JavaBean <code>MovieDB</code> in package <code>com.csd430.beans</code>.</p>

<%
    // Scriptlet block: construct the DB bean and handle an optional delete
    // request. Keep logic here minimal: validate input, call the bean and
    // prepare a user-facing message. All visible HTML is outside this block.
    com.csd430.beans.MovieDB db = new com.csd430.beans.MovieDB();
    String deleteParam = request.getParameter("deleteId");
    String message = null;

    if (deleteParam != null) {
        try {
            int id = Integer.parseInt(deleteParam);
            boolean deleted = db.deleteById(id);
            message = deleted ? ("Record deleted (id=" + id + ")") : ("No record found for id=" + id);
        } catch (NumberFormatException nf) {
            // User-supplied value was not a valid integer
            message = "Invalid id format.";
        }
    }

    // Retrieve the current list of movies after any delete operation so the
    // page always shows an up-to-date view.
    java.util.List<com.csd430.beans.Movie> movies = db.getAllMovies();
%>

<% if (message != null) { %>
    <div class="message"><%= message %></div>
<% } %>

<!-- Display table with thead always present -->
<table>
    <thead>
        <tr>
            <th>ID (key)</th>
            <th>Title</th>
            <th>Genre</th>
            <th>Year</th>
            <th>Director</th>
            <th>Rating</th>
            <th>Notes</th>
        </tr>
    </thead>
    <tbody>
    <% if (movies.isEmpty()) { %>
        <!-- No data rows; table body left empty per assignment -->
    <% } else {
           for (com.csd430.beans.Movie m : movies) {
    %>
        <tr>
            <td><%= m.getId() %></td>
            <td><%= m.getTitle() %></td>
            <td><%= m.getGenre() %></td>
            <td><%= m.getYear() %></td>
            <td><%= m.getDirector() %></td>
            <td><%= m.getRating() %></td>
            <td><%= m.getNotes() %></td>
        </tr>
    <%     }
       } %>
    </tbody>
</table>

<h2>Delete a Record</h2>
<p>Select the <strong>ID</strong> of the record you want to delete then click <em>Delete Selected</em>.</p>
<form method="get" action="list.jsp">
    <label for="deleteId">Select ID:</label>
    <select id="deleteId" name="deleteId">
        <option value="">-- choose id --</option>
        <% for (com.csd430.beans.Movie m : movies) { %>
            <option value="<%= m.getId() %>"><%= m.getId() %> - <%= m.getTitle() %></option>
        <% } %>
    </select>
    <input type="submit" value="Delete Selected" />
</form>

<p><em>Notes:</em> The form uses GET for simplicity so the resulting page shows
the remaining rows and updated dropdown immediately. If all records are deleted
the table will show only the header row per the assignment requirement.</p>

</body>
</html>
