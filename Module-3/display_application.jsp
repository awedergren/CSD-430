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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    // Convert the skills string array into a comma-separated list for display.
    // Use String.join when possible; include a defensive fallback to handle
    // odd encodings (for example when automated POSTs send an array's
    // ToString value such as "System.Object[]").
    String skillsDisplay = "None selected";
    if (skillsArr != null && skillsArr.length > 0) {
      // Defensive: if the client accidentally posted the literal "System.Object[]"
      // (PowerShell can do this when passing an array in the Body hashtable),
      // try to salvage the submitted value or provide a clear fallback message.
      if (skillsArr.length == 1 && "System.Object[]".equals(skillsArr[0])) {
        String raw = request.getParameter("skills");
        if (raw != null && raw.indexOf(',') >= 0) {
          skillsDisplay = raw; // already comma-separated
        } else {
          skillsDisplay = "(multiple values submitted; could not parse)";
        }
      } else {
        // Normal case: join the selected skill tokens into a readable list
        try {
          skillsDisplay = String.join(", ", skillsArr);
        } catch (Throwable t) {
          // Fallback to manual join if String.join is unavailable for any reason
          StringBuilder sb = new StringBuilder();
          for (int i=0;i<skillsArr.length;i++) {
            if (i>0) sb.append(", ");
            sb.append(skillsArr[i]);
          }
          skillsDisplay = sb.toString();
        }
      }
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
  <tr><th>Skills</th><td><%= skillsDisplay %></td></tr>
    <tr><th>Cover Letter / Notes</th><td><pre style="white-space:pre-wrap; font-family:inherit;"><%= coverLetter %></pre></td></tr>
  </table>

  <!-- Field and recode descriptions: provide required documentation about
       each field, any coding used in the form, and how derived values were
       calculated. Kept as static HTML. -->
  <h3>Field &amp; Recode Descriptions</h3>
  <ul>
    <li><strong>Full Name</strong> — Applicant's full name (text input). Maps to <code>fullName</code>.</li>
    <li><strong>Email</strong> — Contact email address (email input). Maps to <code>email</code>.</li>
    <li><strong>Phone</strong> — Contact phone number (tel input). Maps to <code>phone</code>.</li>
    <li><strong>Position Applied For</strong> — Coded select field. Codes used by the form are mapped to readable labels for display:
      <ul>
        <li><code>software_engineer</code> =&gt; Software Engineer</li>
        <li><code>qa_engineer</code> =&gt; QA Engineer</li>
        <li><code>product_manager</code> =&gt; Product Manager</li>
        <li><code>designer</code> =&gt; Designer</li>
      </ul>
    </li>
    <li><strong>Available Start Date</strong> — Date input (ISO yyyy-MM-dd). Displayed as submitted.</li>
    <li><strong>Desired Salary</strong> — Numeric input (USD). Parsed as a number and displayed as whole dollars; parsing errors result in "(not provided)".</li>
    <li><strong>Highest Education</strong> — Radio input captured as text and displayed as submitted.</li>
    <li><strong>Years of Experience</strong> — Numeric input parsed to integer; if omitted the display shows "(not provided)".</li>
    <li><strong>Skills</strong> — Multi-select checkboxes. Submitted values are collected via <code>request.getParameterValues("skills")</code> and shown as a comma-separated list.</li>
    <li><strong>Cover Letter / Notes</strong> — Free-text area preserved with line breaks for readability.</li>
  </ul>

  <h4>Recode rules</h4>
  <ul>
    <li><strong>Experience category</strong> — Derived from Years of Experience:
      <ul>
        <li>Not provided: when years is missing</li>
        <li>Entry-level (0-1 years)</li>
        <li>Early-career (2-4 years)</li>
        <li>Mid-career (5-9 years)</li>
        <li>Senior (10+ years)</li>
      </ul>
    </li>
    <li><strong>Position labels</strong> — The form sends short codes which are mapped in the scriptlet to human-friendly labels for the table display.</li>
  </ul>

  <p class="description">Thank you for submitting your application. This page demonstrates JSP scriptlet usage to retrieve and display form data.</p>

</body>
</html>
