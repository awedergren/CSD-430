<!-- 
    Amanda Wedergren
    November 3, 2025
    Module 4.2 Assignment
-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Application - JavaBean Example</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: Arial, sans-serif; max-width: 900px; margin: 2rem auto; }
        label { display:block; margin-top: .6rem; }
        input, select, textarea { width:100%; padding:.4rem; }
        .two-up { display:grid; grid-template-columns:1fr 1fr; gap:1rem }
        .actions { margin-top:1rem }
    </style>
</head>
<body>

<!-- Page header and purpose description. Keep descriptive text outside scriptlets. -->
<h1>Job Application (JavaBean example)</h1>
<p>This form collects applicant information and posts it to a JSP that constructs a JavaBean
and displays the data in a formatted table. Each input below maps to a property on the
<code>Applicant</code> bean which will be populated from the request parameters.</p>

<form action="display_bean.jsp" method="post">
    <!-- Applicant full name (maps to Applicant.fullName) -->
    <label for="fullName">Full name</label>
    <input type="text" id="fullName" name="fullName" required>

    <div class="two-up">
        <div>
            <!-- Email address (maps to Applicant.email). Using input type=email provides
                 basic browser validation. -->
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <!-- Phone number (maps to Applicant.phone). Kept as free-text to allow
                 multiple phone formats. -->
            <label for="phone">Phone</label>
            <input type="tel" id="phone" name="phone">
        </div>
    </div>

    <!-- Position uses coded values; display JSP will map codes to readable labels. -->
    <label for="position">Position applied for</label>
    <select id="position" name="position">
        <option value="dev">Developer</option>
        <option value="qa">QA Tester</option>
        <option value="pm">Project Manager</option>
        <option value="ux">UX Designer</option>
    </select>

    <div class="two-up">
        <div>
            <!-- Date the applicant can start. Kept as ISO date string for simplicity. -->
            <label for="startDate">Available start date</label>
            <input type="date" id="startDate" name="startDate">
        </div>
        <div>
            <!-- Desired salary; the display page will format this as currency. -->
            <label for="salary">Desired salary (USD)</label>
            <input type="number" id="salary" name="salary" step="0.01" min="0">
        </div>
    </div>

    <!-- Years of experience (numeric). The display page will recode this into categories. -->
    <label>Years of experience</label>
    <input type="number" name="yearsExperience" min="0" max="60">

    <!-- Multi-valued skills field: submitted as multiple request parameters with the
        same name (request.getParameterValues("skills") will return the array). -->
    <label>Skills (check all that apply)</label>
    <label><input type="checkbox" name="skills" value="Java"> Java</label>
    <label><input type="checkbox" name="skills" value="HTML/CSS"> HTML/CSS</label>
    <label><input type="checkbox" name="skills" value="SQL"> SQL</label>
    <label><input type="checkbox" name="skills" value="Testing"> Testing</label>
    <label><input type="checkbox" name="skills" value="Design"> Design</label>

    <!-- Cover letter (free-text). The display page preserves line breaks when showing it. -->
    <label for="coverLetter">Short cover letter</label>
    <textarea id="coverLetter" name="coverLetter" rows="6"></textarea>

    <div class="actions">
        <button type="submit">Submit Application</button>
        <button type="reset">Reset</button>
    </div>
</form>

</body>
</html>
