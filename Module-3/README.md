# Job Application JSP Demo (Module-3 Assignment)

This small demo contains two JSP files for the assignment:

- `job_application.jsp` — the form page. Collects applicant information (text, select, radio, checkbox, textarea, date, number).
- `display_application.jsp` — the form processor / display page. Uses JSP scriptlets to read parameters and display them in an HTML table along with field/record descriptions.

Files are located in this folder. To test locally you need a Java servlet container such as Apache Tomcat (9+ recommended).

How to deploy and test on Windows with Tomcat:

1. Install Apache Tomcat and note the `CATALINA_HOME` folder.
2. Copy the two JSP files to a web application folder. For a quick test, put them in the default ROOT webapp:

   - Copy the files to `%CATALINA_HOME%\webapps\ROOT\Module-3\` (create the Module-3 folder if needed).

   Example PowerShell commands (adjust paths as necessary):

```powershell
$dest = "$env:CATALINA_HOME\webapps\ROOT\Module-3"
New-Item -ItemType Directory -Force -Path $dest
Copy-Item -Path .\job_application.jsp -Destination $dest
Copy-Item -Path .\display_application.jsp -Destination $dest
# Start Tomcat by running catalina.bat or using the Windows service for Tomcat
```

3. Open the form in a browser: http://localhost:8080/Module-3/job_application.jsp
4. Fill out the form and click Submit. The results will be displayed by `display_application.jsp`.

Notes:
- Code is commented in the JSPs.
- Java scriptlets are used in `display_application.jsp` as required.
- All HTML tags are kept outside the scriptlet blocks.
- Display uses an HTML table to present the submitted data and includes field/record descriptions.


