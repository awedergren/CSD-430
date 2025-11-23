Module-8: Movie record select/edit/update (Amanda_movies_data)

Overview
- This module continues the movie database flow used in Modules 6/7. It provides a small JSP-based UI (scriptlets per assignment) to select a movie by primary key, edit fields, and update the `Amanda_movies_data` table.

Files used (keep these)
- `index.jsp` — movie selection dropdown (posts to `edit.jsp`).
- `edit.jsp` — loads the selected movie and shows an edit form (id shown read-only, included as hidden input).
- `update.jsp` — performs the JDBC UPDATE and displays the updated row.
- `WEB-INF/classes/com/csd430/beans/Movie.java` — JavaBean used by the JSPs (simple getters/setters).
- `WEB-INF/classes/db.properties` — database connection properties used at runtime (update to match your DB credentials).
- `CSD430_module6_create_and_populate.sql` — optional SQL script to create the `CSD430` database and populate the `Amanda_movies_data` table with sample rows.

Files removed
- Older/duplicate pages (`movie_select.jsp`, `display_movie.jsp`) and legacy student artifacts were removed to keep the submission focused on the movie flow.

Database setup (MySQL example)
1) Create the `CSD430` database and `Amanda_movies_data` table — the included script `CSD430_module6_create_and_populate.sql` contains the CREATE TABLE and sample INSERTs used during development.

2) Ensure a DB user exists (example uses `student1` / `pass`) or update `WEB-INF/classes/db.properties` with your own credentials.

Deployment
- Copy the `Module-8` folder into Tomcat's `webapps` (or set your webapp root to this folder).
- Make sure the JDBC driver (MySQL Connector/J) is available to Tomcat (place the connector JAR in `C:\tools\apache-tomcat-10.1.14\lib` or in the app's `WEB-INF/lib`).

Quick DB properties example (put under `WEB-INF/classes/db.properties`):

```
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/CSD430?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.user=student1
db.password=pass
```

Notes
- The JSP pages intentionally use scriptlets to satisfy the assignment requirement; all HTML is kept outside the scriptlet blocks.
- I removed duplicate and student-related files and kept the repository minimal for submission.

If you'd like I can:
- Revert the automated test change applied to one movie row (remove the "AUTOTEST" suffix),
- Package the module into a ZIP for submission, or
- Add brief inline comments to each JSP explaining key blocks. 
