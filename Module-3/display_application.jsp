<%--
  Amanda Wedergren
  October 27, 2025
  Module 3.2 assignment
  
  display_application.jsp
  Receives POST data from job_application.jsp and displays submitted values
  in an HTML table. Uses JSP scriptlets to retrieve parameters and do simple
  recoding/formatting. All HTML tags remain outside the Java scriptlets.

  Notes:
  - Scriptlets (<% ... %>) are used per assignment requirement.
  - For multi-valued fields (checkboxes) we use request.getParameterValues.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Application Submitted</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    table { border-collapse: collapse; width: 90%; max-width: 900px; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align:left; }
    th { background:#f4f4f4; width: 220px; }
    caption { font-size:1.2em; margin-bottom:8px; }
    .description { margin-bottom:16px; color:#333; }
  </style>
</head>
<body>
  <h1>Application Received</h1>

  <%-- Overall data summary/description (outside scriptlets it's static HTML) --%>
  <p class="description">Below is a summary of the data you submitted. Field labels are on the left and values are on the right. Numeric values and dates are shown where provided. Multi-select fields are shown as comma-separated lists.</p>

  <%
    // ------------------------------
    // Read and normalize incoming form parameters
    // ------------------------------
    // This block uses JSP scriptlets to access the HttpServletRequest object
    // and retrieve form parameter values submitted by job_application.jsp.
    // Note: in a modern app you'd use MVC controllers or JSTL/EL instead of
    // scriptlets, but the assignment specifically requires scriptlet usage.

    // Single-value parameters from the form (may be null if not submitted)
    String fullName = request.getParameter("fullName");    // text input
    String email = request.getParameter("email");          // email input
    String phone = request.getParameter("phone");          // tel input
    String position = request.getParameter("position");    // select dropdown
    String startDate = request.getParameter("startDate");  // date input (ISO yyyy-MM-dd)
    String salaryStr = request.getParameter("salary");     // numeric as string
    String education = request.getParameter("education");  // radio input
    String yearsExpStr = request.getParameter("yearsExp"); // numeric as string
    String coverLetter = request.getParameter("coverLetter"); // textarea

    // Multi-valued parameter (checkboxes allow multiple values)
    // request.getParameterValues returns null if the parameter is absent
    String[] skillsArr = request.getParameterValues("skills");

    // ------------------------------
    // Convert and sanitize numeric fields with safe defaults
    // ------------------------------
    // yearsExp: parse to int when provided; use -1 to represent 'not provided'
    int yearsExp = -1; // sentinel value meaning 'not provided'
    try {
      if (yearsExpStr != null && yearsExpStr.trim().length() > 0) {
        yearsExp = Integer.parseInt(yearsExpStr);
      }
    } catch (NumberFormatException nfe) {
      // If parsing fails we keep the sentinel -1. In production you'd report an error.
    }

    // salary: convert to Integer (dollar amount). We parse as double first to
    // allow values like "55000.00" then cast to int. On error we leave null.
    Integer salary = null;
    try {
      if (salaryStr != null && salaryStr.trim().length() > 0) {
        salary = Integer.valueOf((int)Double.parseDouble(salaryStr));
      }
    } catch (Exception e) {
      // leave salary as null when parsing fails
      salary = null;
    }

    // ------------------------------
    // Recode / derive helper values for display
    // ------------------------------
    // Determine a human-friendly experience category from yearsExp
    String experienceCategory;
    if (yearsExp < 0) {
      experienceCategory = "Not provided";
    } else if (yearsExp < 2) {
      experienceCategory = "Entry-level (0-1 years)";
    } else if (yearsExp < 5) {
      experienceCategory = "Early-career (2-4 years)";
    } else if (yearsExp < 10) {
      experienceCategory = "Mid-career (5-9 years)";
    } else {
      experienceCategory = "Senior (10+ years)";
    }

    // ------------------------------
    // Format multi-valued fields for presentation
    // ------------------------------
    // Convert the skills string array into a comma-separated list for display
    String skills = "None selected";
    if (skillsArr != null && skillsArr.length > 0) {
      StringBuilder sb = new StringBuilder();
      for (int i=0;i<skillsArr.length;i++) {
        if (i>0) sb.append(", ");
        // Note: values are taken directly from the form. In production sanitize them.
        sb.append(skillsArr[i]);
      }
      skills = sb.toString();
    }

    // ------------------------------
    // Map coded values to human-friendly labels
    // ------------------------------
    // The form sends position values like "software_engineer"; convert those
    // to readable labels for the table.
    String positionLabel = position;
    if ("software_engineer".equals(position)) positionLabel = "Software Engineer";
    else if ("qa_engineer".equals(position)) positionLabel = "QA Engineer";
    else if ("product_manager".equals(position)) positionLabel = "Product Manager";
    else if ("designer".equals(position)) positionLabel = "Designer";
    else if (position == null || position.trim().length()==0) positionLabel = "(not specified)";

    // ------------------------------
    // Ensure no null values are printed directly (replace with helpful text)
    // ------------------------------
    if (fullName == null) fullName = "(not provided)";
    if (email == null) email = "(not provided)";
    if (phone == null || phone.trim().length()==0) phone = "(not provided)";
    if (startDate == null || startDate.trim().length()==0) startDate = "(not provided)";
    if (coverLetter == null || coverLetter.trim().length()==0) coverLetter = "(none)";
    if (education == null) education = "(not specified)";
  %>

  <table>
    <caption>Submitted Application Data</caption>
    <tr><th>Field</th><th>Value</th></tr>
    <tr><th>Full Name</th><td><%= fullName %></td></tr>
    <tr><th>Email</th><td><%= email %></td></tr>
    <tr><th>Phone</th><td><%= phone %></td></tr>
    <tr><th>Position Applied For</th><td><%= positionLabel %></td></tr>
    <tr><th>Available Start Date</th><td><%= startDate %></td></tr>
    <tr><th>Desired Salary (USD)</th><td><%= (salary!=null?"$"+salary.toString():"(not provided)") %></td></tr>
    <tr><th>Highest Education</th><td><%= education %></td></tr>
    <tr><th>Years of Experience</th><td><%= (yearsExp>=0?yearsExp:"(not provided)") %></td></tr>
    <tr><th>Experience Category</th><td><%= experienceCategory %></td></tr>
    <tr><th>Skills</th><td><%= skills %></td></tr>
    <tr><th>Cover Letter / Notes</th><td><pre style="white-space:pre-wrap; font-family:inherit;"><%= coverLetter %></pre></td></tr>
  </table>


  <p class="description">Thank you for submitting your application. This page demonstrates JSP scriptlet usage to retrieve and display form data.</p>

</body>
</html>
