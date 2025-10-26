<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
Amanda Wedergren
October 22, 2025
Module 2.2 Assignment 
--%>

<%--

    Notes: Server-side documentation only. This JSP comment is removed by
    the JSP compiler and will not be sent to the browser.

    Purpose:
    - Demonstrates a dynamic HTML page implemented with JSP scriptlets for a
        coursework assignment. The page builds an in-memory dataset of movie
        records, groups them by a topical category (genre) and renders each group
        as an HTML table. The file intentionally keeps presentation (HTML/CSS)
        separate from the small amount of Java used to create and group the data.

    Important notes:
    - All Java code that constructs data and grouping is placed in JSP
        scriptlet blocks (<% ... %>) or declarations (<%! ... %>). All HTML tags
        themselves are literal outside those scriptlets. Small JSP expressions
        (<%= ... %>) are used only to emit values into the HTML output.
    - The page links to an external stylesheet at `css/movies.css` (relative
        path) so the file can be copied outside the servlet container and still
        resolve styling when served by a web server or previewed in projects.
    - JSP pages must be executed in a servlet container (e.g., Tomcat) for the
        scriptlets to run. Opening the file directly from the filesystem in a
        browser will not execute Java code; it will only show the raw JSP.

    Structure summary:
    1) Declaration: small HTML-escaping helper used when printing values.
    2) Scriptlet: build the list of movie records (minimum 5) and group by
         genre into a LinkedHashMap to preserve insertion order.
    3) HTML: title, dataset description, and a table for each genre group.
--%>

<%--
    Declaration: escapeHtml
    - A compact, defensive HTML-escaping helper to avoid simple XSS when
        echoing values into the page. We intentionally keep this small and
        dependency-free; for production use prefer a well-tested library or JSTL.
    - This declaration does NOT reference JSP implicit objects (safe to place
        here).
--%>
<%!
        private String escapeHtml(String s) {
                if (s == null) return ""; // return empty string for null inputs
                return s.replace("&", "&amp;")
                                .replace("<", "&lt;")
                                .replace(">", "&gt;")
                                .replace("\"", "&quot;");
        }
%>

<%--
    NOTE: The helper above is deliberately minimal. It performs basic HTML
    entity escaping for ampersand, less-than, greater-than and double-quotes.
    It prevents simple cross-site-scripting when inserting user or data values
    into the page. For more complete escaping (URLs, attributes, or other
    contexts) prefer a library or JSTL fn:escapeXml in production code.
--%>

<%
    // SCRIPTLET: Build the dataset and group it by Genre
    // - The following block runs on the server when the JSP is compiled/executed.
    // - It constructs an in-memory List of records. Each record is a Map of
    //   string keys: title, director, year, notes, genre.
    // - This is intentionally done in scriptlet code to satisfy the assignment
    //   requirement to place Java in scriptlet sections. All HTML is outside
    //   scriptlets so the page remains easy to read.
    // - After constructing the list we group records by the 'genre' value
    //   into a LinkedHashMap so insertion order is preserved for display.
    java.util.List<java.util.Map<String,String>> movies = new java.util.ArrayList<>();
    java.util.Map<String,String> rec;

    // Add record 1
    rec = new java.util.HashMap<>();
    rec.put("title","Inception");
    rec.put("director","Christopher Nolan");
    rec.put("year","2010");
    rec.put("genre","Sci-Fi");
    rec.put("notes","A layered dream-heist with strong visuals and ideas.");
    movies.add(rec);

    // Add record 2
    rec = new java.util.HashMap<>();
    rec.put("title","The Shawshank Redemption");
    rec.put("director","Frank Darabont");
    rec.put("year","1994");
    rec.put("genre","Drama");
    rec.put("notes","Powerful story about hope and friendship in prison.");
    movies.add(rec);

    // Add record 3
    rec = new java.util.HashMap<>();
    rec.put("title","The Matrix");
    rec.put("director","The Wachowskis");
    rec.put("year","1999");
    rec.put("genre","Sci-Fi");
    rec.put("notes","Groundbreaking mix of philosophy and action.");
    movies.add(rec);

    // Add record 4
    rec = new java.util.HashMap<>();
    rec.put("title","Amélie");
    rec.put("director","Jean-Pierre Jeunet");
    rec.put("year","2001");
    rec.put("genre","Romance");
    rec.put("notes","A whimsical Parisian tale with warm visuals.");
    movies.add(rec);

    // Add record 5
    rec = new java.util.HashMap<>();
    rec.put("title","Parasite");
    rec.put("director","Bong Joon-ho");
    rec.put("year","2019");
    rec.put("genre","Drama");
    rec.put("notes","Sharp social satire that mixes tones brilliantly.");
    movies.add(rec);

    // Group the list into a LinkedHashMap keyed by genre to preserve insertion order
    // - We use LinkedHashMap so the groups render in the order the genres first
    //   appear in the data above. Each value is a List of record maps.
    java.util.Map<String, java.util.List<java.util.Map<String,String>>> grouped = new java.util.LinkedHashMap<>();
    for (java.util.Map<String,String> m : movies) {
        String g = m.get("genre");
        if (g == null) g = "(unknown)"; // fallback for missing genre
        if (!grouped.containsKey(g)) {
            grouped.put(g, new java.util.ArrayList<java.util.Map<String,String>>());
        }
        grouped.get(g).add(m);
    }

    // A small summary value used in the page header
    int totalRecords = movies.size();

%>

<%--
    Rendering contract (readers):
    - All HTML tags below are literal and live outside scriptlet blocks.
    - Scriptlet loops inject only data values. We always escape values with
      escapeHtml(...) when printing into the HTML to avoid accidental HTML
      injection.
--%>
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Movie Records — JSP Scriptlet Example</title>
    <link rel="stylesheet" href="css/movies.css" />
</head>
<body>
    <header>
        <h1>Movie Records (JSP Scriptlets)</h1>
        <p class="summary">This page demonstrates using JSP Scriptlets to build and render a dynamic HTML table.
           Data are grouped by topical categories (Genre). The page uses an external CSS stylesheet.</p>
    </header>

    <section class="meta">
        <h2>Dataset description</h2>
        <p>This dataset contains <strong><%= totalRecords %></strong> movie records. Each record has the following fields:</p>
        <ul>
            <li><strong>Title</strong> — movie title</li>
            <li><strong>Director</strong> — director name</li>
            <li><strong>Year</strong> — release year</li>
            <li><strong>Notes</strong> — short description (optional)</li>
        </ul>
    </section>

    <section class="data">
        <h2>Records grouped by Genre</h2>

            <%--
               Render phase:
               - If grouped map is empty, show a small message.
               - Otherwise iterate the groups and render a semantic table for each group.
               - We use LinkedHashMap earlier so the order is predictable and matches the
                 order in which genres were first encountered in the dataset.
            --%>
            <% if (grouped.isEmpty()) { %>
                <p><em>No movies to display.</em></p>
            <% } else {
                   for (java.util.Map.Entry<String, java.util.List<java.util.Map<String,String>>> e : grouped.entrySet()) {
                       String genre = e.getKey();
                       java.util.List<java.util.Map<String,String>> rows = e.getValue();
            %>

            <!-- Section for one genre group -->
            <h3><%= escapeHtml(genre) %> (<%= rows.size() %>)</h3>
            <div class="table-wrap">
            <table class="movies">
                <caption>Genre: <%= escapeHtml(genre) %></caption>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Director</th>
                        <th>Year</th>
                        <th>Notes</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    // Row rendering: escape every value before output to avoid simple XSS
                    for (java.util.Map<String,String> r : rows) {
                %>
                    <tr>
                        <td><%= escapeHtml(r.get("title")) %></td>
                        <td><%= escapeHtml(r.get("director")) %></td>
                        <td><%= escapeHtml(r.get("year")) %></td>
                        <td><%= escapeHtml(r.get("notes")) %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            </div>

            <%   }
               }
            %>

    </section>

    <footer>
        <p class="disclaimer">Page generated at <%= new java.util.Date() %> by JSP scriptlets.</p>
    </footer>
</body>
</html>
