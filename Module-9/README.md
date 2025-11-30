```markdown
# Module-9

Workspace for Module-9. This folder contains the Module-9 deliverables for the
Assignment Part 4 (delete-record form). Files in this workspace:

- `src/com/csd430/beans/MovieDB.java` - JavaBean that provides JDBC access
	methods `getAllMovies()` and `deleteById(int)`. Edit the JDBC constants at
	the top to match your database (URL, user, password).
- `web/list.jsp` - Main JSP showing the HTML table, a select dropdown of keys,
	and a delete form. Uses scriptlets as required by the assignment.
- `web/index.jsp` - Simple redirect to `list.jsp`.
- `web/WEB-INF/web.xml` - Minimal deployment descriptor with welcome file.
- `CSD430_module6_create_and_populate.sql` - Canonical SQL to create the
	`CSD430` database, the `Amanda_movies_data` table and the sample rows (also
	creates the sample user `student1` with password `pass`).

Overview / Important values

- Database name: `CSD430`
- Table: `Amanda_movies_data`
- Sample DB user created by the Module‑6 SQL: `student1` / password `pass`

Quick Deploy / Usage

1. Ensure the database is present (run the Module‑6 SQL if needed):

```sql
-- from your MySQL client (example path)
SOURCE C:/csd/CSD-430/Module-9/CSD430_module6_create_and_populate.sql;
```

2. (If you already have the `student1` user but get authentication errors on
	 MySQL 8+) update the user to use the legacy plugin:

```sql
ALTER USER 'student1'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pass';
FLUSH PRIVILEGES;
```

3. Make sure the JDBC driver (for example `mysql-connector-java-8.0.x.jar`) is
	 on the Tomcat classpath: copy it to `TOMCAT_HOME/lib/` or add it to the
	 webapp's `WEB-INF/lib/` as appropriate.

4. Edit the DB connection constants in `src/com/csd430/beans/MovieDB.java` and
	 set the URL/user/password. Example URL (helps avoid common MySQL 8 issues):

```
jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
```

5. Compile the Java sources into your deployed webapp `WEB-INF/classes` (example
	 PowerShell `javac` command that targets the Tomcat webapps path used in this
	 project):

```powershell
javac -d 'C:\tools\apache-tomcat-10.1.14\webapps\module9\WEB-INF\classes' \
	'C:\csd\CSD-430\Module-9\Movie.java' \
	'C:\csd\CSD-430\Module-9\src\com\csd430\beans\MovieDB.java'
```

6. Clear the Tomcat JSP work directory to force a fresh JSP compile, restart
	 Tomcat, then open the app at:

```
http://localhost:8080/module9/
```

Troubleshooting checklist

- Confirm the Module‑6 SQL has been executed and the `CSD430` DB exists.
- Confirm the MySQL user `student1` exists and has the `mysql_native_password`
	plugin (or add `allowPublicKeyRetrieval=true` to the JDBC URL).
- Confirm the MySQL Connector/J JAR is present in Tomcat `lib` or the webapp
	`WEB-INF/lib` so the JDBC driver is available at runtime.
- Confirm compiled classes are in `WEB-INF/classes/com/csd430/beans/`.
- If JSP import errors occur, open `web/list.jsp` and use fully-qualified
	class names (or ensure the `package` declarations and compiled classes match).

Notes / Testing

- The JSPs use scriptlets for business logic as required by the assignment. All
	database access is performed by the `MovieDB` JavaBean.
- The table shown in `list.jsp` contains at least five fields (title, genre,
	year, director, rating) and preserves the header row (`<thead>`) when there
	are no data rows.
- When you delete the last record the page will show the table header and an
	empty body, and the dropdown will have no selectable IDs.

Automation / optional

- If you want, I can compile the JavaBean into `WEB-INF/classes/` for you
	locally, copy the connector JAR to Tomcat `lib`, and restart Tomcat. I can
	also add a small PowerShell build script (`build.ps1`) to automate the
	`javac` step.

````