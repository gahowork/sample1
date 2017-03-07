echo off

set logfile=create_db.log
set username=sa
set passwd=123User!
set servername=127.0.0.1\sqlexpress
set database=master

set automode=0
set noixmode=0
set nockmode=0
set nofimode=0
set nospmode=0
set noinsmode=0

if /I .%1 == .AUTO set automode=1
if /I .%1 == .NOIX set noixmode=1
if /I .%1 == .NOCK set nockmode=1
if /I .%1 == .NOFI set nofimode=1
if /I .%1 == .NOSP set nospmode=1
if /I .%1 == .NOINS set noinsmode=1

if /I .%2 == .AUTO set automode=1
if /I .%2 == .NOIX set noixmode=1
if /I .%2 == .NOCK set nockmode=1
if /I .%2 == .NOFI set nofimode=1
if /I .%2 == .NOSP set nospmode=1
if /I .%2 == .NOINS set noinsmode=1

if /I .%3 == .AUTO set automode=1
if /I .%3 == .NOIX set noixmode=1
if /I .%3 == .NOCK set nockmode=1
if /I .%3 == .NOFI set nofimode=1
if /I .%3 == .NOSP set nospmode=1
if /I .%3 == .NOINS set noinsmode=1

if /I .%4 == .AUTO set automode=1
if /I .%4 == .NOIX set noixmode=1
if /I .%4 == .NOCK set nockmode=1
if /I .%4 == .NOFI set nofimode=1
if /I .%4 == .NOSP set nospmode=1
if /I .%4 == .NOINS set noinsmode=1

if /I .%5 == .AUTO set automode=1
if /I .%5 == .NOIX set noixmode=1
if /I .%5 == .NOCK set nockmode=1
if /I .%5 == .NOFI set nofimode=1
if /I .%5 == .NOSP set nospmode=1
if /I .%5 == .NOINS set noinsmode=1

if /I .%6 == .AUTO set automode=1
if /I .%6 == .NOIX set noixmode=1
if /I .%6 == .NOCK set nockmode=1
if /I .%6 == .NOFI set nofimode=1
if /I .%6 == .NOSP set nospmode=1
if /I .%6 == .NOINS set noinsmode=1

echo > %logfile%
call :showmsg .
call :showmsg "starting database creation %TIME%"
call :showmsg .

call :docmd "try dropping database" 01_drop_db.sql
call :docmd "try creating database" 02_create_db.sql
call :docmddb "try creating tables" 03_create_table.sql
call :docmddb "try creating primary keys" 04_create_pk.sql
call :docmddb "try creating foreign keys" 05_create_fk.sql
if %noixmode% == 0 call :docmddb "try creating indexes" 06_create_index.sql
if %nofimode% == 0 call :docmddb "try creating function" 07_create_function.sql
if %nockmode% == 0 call :docmddb "try creating checks" 08_create_check.sql
if %nospmode% == 0 call :docmddb "try creating procedures" 09_create_procedure.sql
if %nockmode% == 0 call :docmddb "try inserting values" 10_insert.sql

call :showmsg .
call :showmsg "stopping database creation %TIME%"
call :showmsg .

if %automode% == 1  goto :eof
pause

goto :eof

:docmd
	call :showmsg %1
	osql -S %servername% -U %username% -P %passwd% -d master -i %2 >> %logfile%
	echo. >> %logfile%
	echo. >> %logfile%
	goto :eof

:docmddb
	call :showmsg %1
	osql -S %servername% -U %username% -P %passwd% -d %database% -i %2 >> %logfile%
	echo. >> %logfile%
	echo. >> %logfile%
	goto :eof

:showmsg
	echo %1
	echo %1 >> %logfile%

:eof
