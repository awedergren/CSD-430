<%--
  Amanda Wedergren
  October 27, 2025
  Module 3.2 assignment
  
  job_application.jsp
  A simple job application form (JSP) that collects applicant data.
  All HTML elements are outside scriptlets. This file only contains the form
  and descriptive content. The form posts to display_application.jsp via POST.
--%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Job Application Form</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    fieldset { margin-bottom: 18px; }
    label { display:block; margin-top:8px; }
    .note { font-size:0.9em; color:#555; }
  </style>
</head>
<body>
  <h1>Job Application</h1>

  <p class="note">Please complete the form below. Fields marked with * are required.</p>

  <%--
    Overall data description:
    - We collect applicant identity (name, email, phone)
    - Position applied for and availability
    - Desired salary and years of experience
    - Education level (radio), skills (checkboxes), and a short cover letter

    Notes about form structure and validation:
    - All HTML is kept outside of Java scriptlets.
    - The form uses semantic inputs where possible (email, date, number, tel).
    - Required fields are marked with the required attribute; server-side
      validation is implemented in display_application.jsp using scriptlets.
  --%>

  <form method="post" action="display_application.jsp">
    <fieldset>
      <legend>Applicant Information</legend>
      <%--
        fullName: text input. Required on the client side via 'required'.
        maxlength helps guard accidental long input.
      --%>
      <label for="fullName">Full Name *</label>
      <input type="text" id="fullName" name="fullName" required maxlength="100" />

      <%-- email: uses browser email validation when available --%>
      <label for="email">Email *</label>
      <input type="email" id="email" name="email" required />

      <%-- phone: optional; no strict pattern enforced here, placeholder for guidance --%>
      <label for="phone">Phone</label>
      <input type="tel" id="phone" name="phone" placeholder="555-123-4567" />
    </fieldset>

    <fieldset>
      <legend>Position & Availability</legend>
      <%--
        position: select element. Values are coded strings (used later for recoding).
        startDate: HTML date input (value submitted in yyyy-MM-dd format).
        salary: numeric input; step=100 so user can enter whole-dollar amounts.
      --%>
      <label for="position">Position Applied For *</label>
      <select id="position" name="position" required>
        <option value="">-- Select position --</option>
        <option value="software_engineer">Software Engineer</option>
        <option value="qa_engineer">QA Engineer</option>
        <option value="product_manager">Product Manager</option>
        <option value="designer">Designer</option>
      </select>

      <label for="startDate">Available Start Date</label>
      <input type="date" id="startDate" name="startDate" />

      <label for="salary">Desired Salary (USD)</label>
      <input type="number" id="salary" name="salary" min="0" step="100" />
    </fieldset>

    <fieldset>
      <legend>Experience & Education</legend>
      <%--
        education: single-choice radio buttons. One value will be sent.
        skills: checkboxes use the same name for multiple values; on the server
                use request.getParameterValues("skills") to retrieve them.
        yearsExp: numeric field representing total years of experience.
      --%>
      <label>Highest Education</label>
      <label><input type="radio" name="education" value="high_school" /> High School</label>
      <label><input type="radio" name="education" value="associate" /> Associate</label>
      <label><input type="radio" name="education" value="bachelor" checked /> Bachelor</label>
      <label><input type="radio" name="education" value="master" /> Master</label>
      <label><input type="radio" name="education" value="phd" /> PhD</label>

      <%-- Checkboxes: technical skills (multiple values) --%>
      <label>Skills (check all that apply)</label>
      <label><input type="checkbox" name="skills" value="java" /> Java</label>
      <label><input type="checkbox" name="skills" value="javascript" /> JavaScript</label>
      <label><input type="checkbox" name="skills" value="sql" /> SQL</label>
      <label><input type="checkbox" name="skills" value="react" /> React</label>
      <label><input type="checkbox" name="skills" value="aws" /> AWS</label>

      <label for="yearsExp">Years of Experience</label>
      <input type="number" id="yearsExp" name="yearsExp" min="0" max="60" step="1" />
    </fieldset>

    <fieldset>
      <legend>Cover Letter</legend>
      <%--
        coverLetter: optional free-text field. We include maxlength to encourage
        concise responses. The display page wraps the text for readability.
      --%>
      <label for="coverLetter">Short Cover Letter / Notes</label>
      <textarea id="coverLetter" name="coverLetter" rows="6" cols="60" maxlength="2000"
        placeholder="Why are you a good fit? (max 2000 chars)"></textarea>
    </fieldset>

    <p>
      <button type="submit">Submit Application</button>
      <button type="reset">Reset</button>
    </p>
  </form>

  <hr />
  <p class="note">This form is for assignment use only. Data submitted will be displayed using JSP scriptlets on the next page.</p>
</body>
</html>
