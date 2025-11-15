Module 5 — CSD430 Database Deliverables

Overview
-
This folder contains a SQL script and helper files to create the CSD430 database, create a student user `student1` (password `pass`) and a sample table named `Amanda_movies_data` populated with 10 example rows.

Files
-
- sql/CSD430_create_and_populate.sql — SQL script to create the database, user, table, and populate sample rows.
- web/index.jsp — A basic index page that documents the files and quick instructions.
- scripts/import_example.ps1 — PowerShell example to import the SQL file using the local mysql client.
- deliverables/ — Place your screenshots (database created, table rows) and any exported CSVs here.

How to run (Windows, PowerShell)
-
1. Install MySQL Server if not already installed.
2. Edit `sql/CSD430_create_and_populate.sql` if your environment cannot create new MySQL users (remove the CREATE USER/GRANT lines).
3. Open PowerShell as Administrator (or a user with privileges to run mysql as root) and run:
   & "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -u root -p < "C:\\csd\\CSD-430\\Module-5\\sql\\CSD430_create_and_populate.sql"
4. When prompted, enter the root password. The script will create the database and the `student1` user and populate the `Amanda_movies_data` table.
5. Verify with:
   mysql -u student1 -p -D CSD430 -e "SELECT * FROM Amanda_movies_data LIMIT 10;"

Notes
-
- If you're using a hosted or shared DB where root access isn't available, remove the CREATE USER and GRANT lines from the SQL and instead have your instructor create the database/user for you. The rest of the script (CREATE TABLE / INSERT) will still work when run by a user with privileges to create tables.
- If you want a different student table name (replace "Amanda" with your first name), tell me the first name and I'll regenerate the SQL and links accordingly.

Deliverables checklist
-
- [ ] SQL script: sql/CSD430_create_and_populate.sql
- [ ] Screenshot: database `CSD430` exists (showing in MySQL client or Workbench)
- [ ] Screenshot: `Amanda_movies_data` table with 10+ rows
- [ ] README.md explaining how you ran the script

