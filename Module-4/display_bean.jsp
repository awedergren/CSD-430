<!-- Amanda Wedergren
     November 3, 2025
     Module 4.2 Assignment
-->

<%@ page import="com.wedergren.beans.Applicant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Applicant Details</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 900px; margin: 2rem auto; }
        table { border-collapse: collapse; width:100%; }
        th, td { border: 1px solid #ccc; padding:.6rem; text-align:left }
        th { background:#f5f5f5 }
        .meta { font-size:.9rem; color:#555 }
    </style>
</head>
<body>

<h1>Applicant Details</h1>
<p class="meta">This page demonstrates using a JavaBean created and populated in a JSP scriptlet
and rendered into an HTML table. All HTML tags are outside of Java scriptlets per the assignment.</p>

<%
    /*
     * Scriptlet section: all Java code required to read request parameters,
     * construct and populate the Applicant JavaBean, and perform light
     * recoding (e.g. mapping position codes to labels, recoding experience
     * buckets). Per the assignment, HTML output is kept outside of scriptlets.
     */
    // Read request parameters (these come from job_application.jsp form fields)
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String position = request.getParameter("position");
    String startDate = request.getParameter("startDate");
    String salaryStr = request.getParameter("salary");
    String yearsStr = request.getParameter("yearsExperience");
    String[] skills = request.getParameterValues("skills");
    String coverLetter = request.getParameter("coverLetter");

    Applicant a = new Applicant();
    // Populate bean fields, providing safe defaults when parameters are missing
    a.setFullName(fullName == null ? "(not provided)" : fullName);
    a.setEmail(email == null ? "(not provided)" : email);
    a.setPhone(phone == null ? "(not provided)" : phone);

    // Recode the position code into a human readable label for display
    String posLabel = "Other";
    if ("dev".equals(position)) posLabel = "Developer";
    else if ("qa".equals(position)) posLabel = "QA Tester";
    else if ("pm".equals(position)) posLabel = "Project Manager";
    else if ("ux".equals(position)) posLabel = "UX Designer";
    a.setPosition(posLabel);

    // Keep start date as a plain string for display; a more robust implementation
    // could parse to java.time.LocalDate.
    a.setStartDate(startDate == null || startDate.isEmpty() ? "(not specified)" : startDate);

    // Parse numeric inputs defensively (use defaults on parse errors)
    double salary = 0.0;
    try {
        if (salaryStr != null && !salaryStr.isEmpty()) salary = Double.parseDouble(salaryStr);
    } catch (NumberFormatException e) {
        salary = 0.0; // default on parse error
    }
    a.setSalary(salary);

    int years = 0;
    try {
        if (yearsStr != null && !yearsStr.isEmpty()) years = Integer.parseInt(yearsStr);
    } catch (NumberFormatException e) {
        years = 0; // fallback to zero if parse fails
    }
    a.setYearsExperience(years);

    // Store multi-valued skills and cover letter (preserve empty string if missing)
    a.setSkills(skills);
    a.setCoverLetter(coverLetter == null ? "" : coverLetter);

    // Recode yearsExperience into a category used in the display
    String experienceCategory = "Entry";
    if (years >= 8) experienceCategory = "Senior";
    else if (years >= 4) experienceCategory = "Mid";

%>

<!-- Display section: HTML outside scriptlets -->
<h2>Summary</h2>
<p>The following table shows the submitted applicant data. Below the table are
field descriptions and recode notes required by the assignment.</p>

<table>
    <tr><th>Field</th><th>Value</th></tr>
    <tr><td>Full name</td><td><%= a.getFullName() %></td></tr>
    <tr><td>Email</td><td><%= a.getEmail() %></td></tr>
    <tr><td>Phone</td><td><%= a.getPhone() %></td></tr>
    <tr><td>Position</td><td><%= a.getPosition() %></td></tr>
    <tr><td>Available start date</td><td><%= a.getStartDate() %></td></tr>
    <tr><td>Desired salary</td><td><%= String.format("$%,.2f", a.getSalary()) %></td></tr>
    <tr><td>Years experience (raw)</td><td><%= a.getYearsExperience() %></td></tr>
    <tr><td>Experience (recode)</td><td><%= experienceCategory %></td></tr>
    <tr><td>Skills</td><td><%= (a.getSkills() == null ? "(none)" : String.join(", ", a.getSkills())) %></td></tr>
    <tr><td>Cover letter</td><td><pre style="white-space:pre-wrap;margin:0"><%= a.getCoverLetter() %></pre></td></tr>
</table>

<h3>Field & recode descriptions</h3>
<ul>
    <li><strong>Full name</strong> - applicant's full name (text).</li>
    <li><strong>Email</strong> - contact email (email format encouraged).</li>
    <li><strong>Phone</strong> - contact phone number (free-text).</li>
    <li><strong>Position</strong> - coded values: <code>dev</code>=Developer, <code>qa</code>=QA Tester, <code>pm</code>=Project Manager, <code>ux</code>=UX Designer.</li>
    <li><strong>Start date</strong> - date applicant can begin.</li>
    <li><strong>Desired salary</strong> - numeric, displayed as currency.</li>
    <li><strong>Years experience</strong> - numeric; recoded into categories below.</li>
    <li><strong>Skills</strong> - multi-select checkboxes stored as a String array.</li>
    <li><strong>Cover letter</strong> - free-text, displayed preserving line breaks.</li>
</ul>

<h3>Recode rules</h3>
<ul>
    <li>Experience category: 0-3 years = Entry, 4-7 = Mid, 8+ = Senior.</li>
    <li>Position codes are mapped to human-readable labels in the bean population scriptlet.</li>
</ul>

<p class="meta">Notes: The Applicant bean implements <code>java.io.Serializable</code>. All Java
logic used to assemble the bean was placed inside a JSP scriptlet (top of page).
All HTML tags remain outside scriptlets.</p>

</body>
</html>
