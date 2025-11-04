Wedergren_JavaBean - Module 4

This workspace contains a simple JavaBean and JSP pages for the Module 4
assignment. The goal is to demonstrate creating a JavaBean (implements
java.io.Serializable), populating it using JSP scriptlets, and rendering the
bean's data in an HTML table. All HTML tags are outside scriptlets as
required by the assignment.

Files created:
- `src/main/java/com/wedergren/beans/Applicant.java` - the JavaBean (Serializable).
- `web/job_application.jsp` - form to collect applicant data (posts to display JSP).
- `web/display_bean.jsp` - constructs and populates the `Applicant` bean using a JSP scriptlet, then displays the data in an HTML table.
- `web/WEB-INF/web.xml` - minimal web.xml with welcome file.

Notes and how to use:
- To run on Tomcat: compile `Applicant.java` and place the resulting `.class` in `WEB-INF/classes/com/wedergren/beans/Applicant.class` (or build a WAR via Maven and deploy).
- Alternatively, you can place the source under `WEB-INF/classes` and let some containers compile on the fly; but the recommended way is to compile and deploy.

Development tips:
- A simple Maven build can be added if you want to produce a WAR. This scaffold omits a full Maven pom to keep the workspace light; tell me if you want a `pom.xml` and I will add one.

Assignment checklist satisfied:
- JavaBean implements `Serializable`.
- Scriptlets are used in `display_bean.jsp` to assemble the bean.
- HTML tags are outside scriptlets.
- Data displayed in an HTML table.
- Field and recode descriptions are included.
- Minimum of 5 input fields present in the form.
