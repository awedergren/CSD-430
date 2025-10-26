<%--
  Amanda Wedergren
  October 22, 2025
  Module 1.2 Assignment
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
        Java declarations (kept short and reusable)

        <%--
            Footer section
            - Shows the server-side generation time so the student can see when the
              JSP executed. This is useful when the page is cached in the browser or
              when verifying that redeploys took effect.
            - Also prints the request parameters (if any) by iterating over
              request.getParameterNames(). We escape all values using the
              escapeHtml() helper defined above to prevent accidental HTML injection
              and to keep the output readable if parameters contain special
              characters.
        --%>
        <footer>
            <p>Generated at: <%= new java.util.Date() %></p>
            <p class="meta">Request parameters:
                <ul>
                    <%-- Iterate request parameters and show name/value pairs --%>
                    <%
                        java.util.Enumeration<String> names = request.getParameterNames();
                        while (names.hasMoreElements()) {
                            String n = names.nextElement();
                    %>
                    <li><strong><%= escapeHtml(n) %>:</strong> <%= escapeHtml(request.getParameter(n)) %></li>
                    <% } %>
                </ul>
            </p>
        </footer>
                if (s == null) return "";
                // Minimal HTML escaping (ampersand, lt, gt, quote)
                return s.replace("&", "&amp;")
                                .replace("<", "&lt;")
                                .replace(">", "&gt;")
                                .replace("\"", "&quot;");
        }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Hello JSP — Example</title>
    <style>
        body { font-family: Segoe UI, Roboto, Arial, sans-serif; margin: 1.5rem; }
        code { background:#f3f3f3; padding:2px 6px; border-radius:4px; }
        .meta { color:#555; font-size:0.95rem }
    </style>
</head>
<body>
    <header>
        <h1>Hello from JSP</h1>
        <p class="meta">This page demonstrates a standards-friendly JSP with minimal Java code.</p>
    </header>

    <%--
        Server information section
        - Shows current server time (formatted) to indicate the page is
          generated dynamically on the server.
        - Shows servlet container information using the implicit 'application'
          object (may be null in some containers or contexts).
        - Displays the HTTP request method used for this request.
        Note: Values printed here are escaped with escapeHtml where appropriate.
    --%>
    <section>
        <h2>Server information</h2>
        <p>Server time: <strong><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()) %></strong></p>
        <p>Servlet container: <strong><%= escapeHtml((application != null) ? String.valueOf(application.getServerInfo()) : "(unknown)") %></strong></p>
        <p>Request method: <strong><%= escapeHtml(request.getMethod()) %></strong></p>
    </section>

    <%--
        Query / Parameters section
        - Demonstrates how to access the raw query string and parsed request
          parameters via the implicit 'request' object.
        - Uses request.getParameterMap() to obtain a Map<String,String[]>
          of parameter names to values. We iterate and print them safely.
        - The small form below allows submitting a 'name' parameter to see
          how it appears in the parameter list and raw query string.
        Security note: This example echoes values back to the user for demo
        purposes only; in production avoid reflecting untrusted input or
        ensure strict validation.
    --%>
    <section>
        <h2>Query / Parameters</h2>
        <p>Raw query string: <code><%= escapeHtml(request.getQueryString()) %></code></p>
        <p>Parameters:</p>
        <ul>
            <% java.util.Map<String,String[]> params = request.getParameterMap();
               if (params == null || params.isEmpty()) { %>
               <li><em>(no parameters)</em></li>
            <% } else {
                   for (java.util.Map.Entry<String,String[]> e : params.entrySet()) {
                       String name = e.getKey();
                       String[] vals = e.getValue(); %>
                       <li><strong><%= escapeHtml(name) %></strong>: <%= escapeHtml(java.util.Arrays.toString(vals)) %></li>
            <%     }
               }
            %>
        </ul>

        <form method="get" action="">
            <label for="name">Enter name: </label>
            <input id="name" name="name" type="text" value="" />
            <button type="submit">Submit</button>
        </form>
    </section>

    <%--
        Helpful links section
        - Shows example links that use response.encodeURL() which ensures URL
          session encoding is preserved when cookies are not available.
        - The links point to: this JSP (refresh), the Hello servlet (if deployed),
          and a context-relative path to the JSP. response.encodeURL is used as
          a demonstration of best practice for session-aware URLs.
    --%>
    <section>
        <h2>Links</h2>
        <ul>
            <li><a href="<%= response.encodeURL("hello.jsp") %>">This JSP (refresh)</a></li>
            <li><a href="<%= response.encodeURL("hello") %>">HelloServlet (if deployed) — /hello</a></li>
            <li><a href="<%= response.encodeURL("hello/hello.jsp") %>">Full path to this JSP (context + JSP)</a></li>
        </ul>
    </section>

    <footer>
        <hr/>
        <p class="meta">Generated at <%= new java.util.Date() %></p>
    </footer>
</body>
</html>
