<%@ page import="java.sql.*, java.util.Map, java.util.HashMap" %>
<%
    // Movie update: read params and update Amanda_movies_data table
    String idParam = request.getParameter("id");
    String title = request.getParameter("title");
    String genre = request.getParameter("genre");
    String yearParam = request.getParameter("year");
    String director = request.getParameter("director");
    String ratingParam = request.getParameter("rating");
    String notes = request.getParameter("notes");

    String message = null;
    int id = -1;
    Map<String, Object> updated = null;
    try {
        if (idParam == null) throw new Exception("ID missing");
        id = Integer.parseInt(idParam);
        int year = 0; double rating = 0.0;
        try { year = Integer.parseInt(yearParam); } catch (Exception ex) { year = 0; }
        try { rating = Double.parseDouble(ratingParam); } catch (Exception ex) { rating = 0.0; }

        String jdbcUrl = "jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String dbUser = "student1";
        String dbPass = "pass";
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection c = DriverManager.getConnection(jdbcUrl, dbUser, dbPass)) {
            String sql = "UPDATE Amanda_movies_data SET title = ?, genre = ?, year = ?, director = ?, rating = ?, notes = ? WHERE id = ?";
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, title);
                ps.setString(2, genre);
                ps.setInt(3, year);
                ps.setString(4, director);
                ps.setDouble(5, rating);
                ps.setString(6, notes);
                ps.setInt(7, id);
                int rows = ps.executeUpdate();
                if (rows > 0) message = "Record updated successfully."; else message = "No rows updated (record may not exist).";
            }

            // re-query updated row
            String sel = "SELECT id, title, genre, year, director, rating, notes FROM Amanda_movies_data WHERE id = ?";
            try (PreparedStatement ps2 = c.prepareStatement(sel)) {
                ps2.setInt(1, id);
                try (ResultSet rs = ps2.executeQuery()) {
                    if (rs.next()) {
                        updated = new HashMap<>();
                        updated.put("id", rs.getInt("id"));
                        updated.put("title", rs.getString("title"));
                        updated.put("genre", rs.getString("genre"));
                        updated.put("year", rs.getInt("year"));
                        updated.put("director", rs.getString("director"));
                        updated.put("rating", rs.getDouble("rating"));
                        updated.put("notes", rs.getString("notes"));
                    }
                }
            }
        }
    } catch (Exception e) {
        message = "Error updating record: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Result</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f2f6fb; color:#222 }
        .card { max-width:900px;margin:30px auto;background:white;padding:18px;border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,0.06) }
        table { width:100%; border-collapse:collapse; margin-top:12px }
        th, td { padding:8px; border:1px solid #e0e0e0; text-align:left }
        th { background:#fafafa }
        .muted { color:#666 }
    </style>
</head>
<body>
<div class="card">
    <h2>Update Result</h2>
    <p><strong><%= message %></strong></p>

    <% if (updated != null) { %>
        <table>
            <tr>
                <th>Field (type)</th>
                <th>Value</th>
            </tr>
            <tr>
                <td><strong>id (int)</strong></td>
                <td><%= updated.get("id") %></td>
            </tr>
            <tr>
                <td><strong>title (String)</strong></td>
                <td><%= updated.get("title") %></td>
            </tr>
            <tr>
                <td><strong>genre (String)</strong></td>
                <td><%= updated.get("genre") %></td>
            </tr>
            <tr>
                <td><strong>year (int)</strong></td>
                <td><%= updated.get("year") %></td>
            </tr>
            <tr>
                <td><strong>director (String)</strong></td>
                <td><%= updated.get("director") %></td>
            </tr>
            <tr>
                <td><strong>rating (double)</strong></td>
                <td><%= updated.get("rating") %></td>
            </tr>
            <tr>
                <td><strong>notes (String)</strong></td>
                <td><%= updated.get("notes") %></td>
            </tr>
        </table>
    <% } else { %>
        <p class="muted">No record to display. Return to <a href="index.jsp">selection</a>.</p>
    <% } %>

    <p style="margin-top:14px"><a href="index.jsp">Back to selection</a></p>
</div>
</body>
</html>
