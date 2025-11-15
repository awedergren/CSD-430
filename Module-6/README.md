Module 6 — JavaBean + JSP: Read from DB and display record

Overview
-
This Module-6 scaffold demonstrates reading a database record using a JavaBean and displaying it in a JSP. The form (`job_select.jsp`) shows a dropdown of the key values (primary keys) from the `Amanda_movies_data` table. The user selects one key and submits to `display_movie.jsp` which loads the record into a `Movie` JavaBean and displays it in an HTML table.

Files
-
- sql/CSD430_module6_create_and_populate.sql — SQL to create the `CSD430` database and `Amanda_movies_data` table and insert 10 sample rows. Edit or remove CREATE USER / GRANT lines if you cannot create users.
- src/com/csd430/beans/Movie.java — JavaBean (Serializable) matching the table columns.
- web/job_select.jsp — JSP showing a dropdown of keys (uses scriptlets and JDBC to query the DB).
- web/display_movie.jsp — JSP that populates a `Movie` bean and displays fields in an HTML table (uses scriptlets).
- web/WEB-INF/web.xml — welcome-file configuration.
- scripts/db.properties — JDBC connection placeholder.
- .code-workspace — VS Code workspace file (created automatically).

Notes & setup
-
1. Make sure MySQL server is running and the `CSD430` database exists (run the SQL in `sql/`):
   - From PowerShell: 
     & "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p < "C:\csd\CSD-430\Module-6\sql\CSD430_module6_create_and_populate.sql"
2. Ensure MySQL Connector/J (the JDBC driver jar) is available to Tomcat. Place the connector JAR into the webapp's `WEB-INF/lib` or Tomcat's global `lib` folder.
3. Build/compile the JavaBean and place the `.class` into `web/WEB-INF/classes/com/csd430/beans/` (or set up a proper Java web project build). Minimal compile example:
   - javac -cp "path\to\mysql-connector-java.jar" -d "C:\csd\CSD-430\Module-6\web\WEB-INF\classes" "C:\csd\CSD-430\Module-6\src\com\csd430\beans\Movie.java"
4. Deploy the `web/` folder to Tomcat (copy into a webapp folder under `apache-tomcat\webapps\Module-6`) and restart Tomcat.
5. Open in browser: http://localhost:8080/Module-6/job_select.jsp

Requirements checklist
-
- Uses Scriptlets for Java logic in JSPs (assignment requirement).
- All HTML tags are outside scriptlets.
- Display uses an HTML table with thead and tbody and at least 5 fields.
- Includes documentation and field descriptions.

If you want me to:
- Compile the Java source and place .class files into WEB-INF/classes (I can do that if you give me javac/jdk path),
- Remove the CREATE USER statements from SQL (for hosted DBs),
- Change the table name from "Amanda_movies_data" to your first name (replace Amanda),
then tell me which and I will update the files accordingly.
