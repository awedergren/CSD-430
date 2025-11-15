# PowerShell example: Import the Module-5 SQL into MySQL
# Adjust paths and credentials to match your environment.

$mysqlExe = "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe"
$sqlFile = "C:\\csd\\CSD-430\\Module-5\\sql\\CSD430_create_and_populate.sql"

if (!(Test-Path $mysqlExe)) {
  Write-Host "mysql.exe not found at $mysqlExe. Edit this script to point to your mysql client." -ForegroundColor Yellow
  exit 1
}

# Run as root/admin to create the database and student user. You'll be prompted for the root password.
& $mysqlExe -u root -p < $sqlFile

Write-Host "Import completed (if credentials were correct). Verify with: mysql -u student1 -p -D CSD430 -e \"SELECT COUNT(*) FROM Amanda_movies_data;\"" -ForegroundColor Green
