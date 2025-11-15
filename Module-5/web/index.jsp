<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Module-5 — CSD430 Database Deliverables</title>
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.4; margin: 24px; }
    main { max-width: 900px; }
    table { border-collapse: collapse; width: 100%; }
    th, td { text-align: left; padding: 8px; border: 1px solid #ddd; }
  </style>
</head>
<body>
  <main>
    <h1>Module 5 — Database Deliverables</h1>
    <p>This folder contains the SQL script and example instructions to create the <strong>CSD430</strong> database, create a student table named <code>Amanda_movies_data</code>, and populate it with sample rows for the assignment.</p>

    <h2>Files</h2>
    <table>
      <tr><th>File</th><th>Description</th></tr>
      <tr><td><a href="/Module-5/sql/CSD430_create_and_populate.sql">CSD430_create_and_populate.sql</a></td><td>SQL script to create database, user `student1`, and the table <code>Amanda_movies_data</code> with 10 sample rows.</td></tr>
      <tr><td><a href="/Module-5/scripts/import_example.ps1">import_example.ps1</a></td><td>PowerShell example script to run the SQL file using the MySQL command-line client (example only).</td></tr>
      <tr><td><a href="/Module-5/README.md">README.md</a></td><td>Instructions and notes for running the SQL script and taking screenshots.</td></tr>
    </table>

    <h2>Quick instructions</h2>
    <ol>
      <li>Install MySQL (or use the provided MySQL server).</li>
      <li>Run the SQL script as a privileged user (root) to create the database and student account, or edit the script to remove the CREATE USER section if not permitted.</li>
      <li>Use the provided PowerShell example (or run mysql -u root -p &lt; CSD430_create_and_populate.sql) to import the data.</li>
      <li>Verify with: <code>mysql -u student1 -p -D CSD430 -e "SELECT * FROM Amanda_movies_data LIMIT 10;"</code></li>
    </ol>

    <h2>Deliverables</h2>
    <ul>
      <li>SQL script: <code>CSD430_create_and_populate.sql</code></li>
      <li>Screenshot: database created</li>
      <li>Screenshot: table <code>Amanda_movies_data</code> with 10+ rows</li>
      <li>Short README describing how you ran the script</li>
    </ul>

    <p>If you want a different student table name (replace <code>Amanda</code>), tell me the first name to use and I'll update the SQL and links.</p>
  </main>
</body>
</html>
