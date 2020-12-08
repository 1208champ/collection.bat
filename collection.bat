:TKT
set /p TKTNUM=What is the ticket number for this report? (e.g. 0001):
ECHO You entered: "%TKTNUM%"
set /p CHKTKT=Is this correct? (y/n)
If /i "%CHKTKT%"=="n" goto :TKT
cls


:USR
set /p USRNAME=Enter the userID authenticated at the time of the incident (e.g. bmookie):
ECHO You entered: "%USRNAME%"
set /p USR=Is this correct? (y/n)
If /i "%USR%"=="n" goto :USR
cls

 
REM Create location to save results
mkdir %TKTNUM%-%COMPUTERNAME%-Results
set resultsDir=%TKTNUM%-%COMPUTERNAME%-Results

REM Run commands to collect system information.
echo Collecting Running Processes
tasklist /svc /FO CSV > "%resultsDir%\tasklist.csv"


echo Collecting network statistics
netstat -an > "%resultsDir%\netstat.txt"

REM Commands I added for assignment are below. Everything above was provided and it correct.


REM Collect Port History | Cports from NirSoft
echo Collecting ports status
cports\cports.exe /scomma "%resultsDir%\cports.csv"


REM Collect Broswer History | Broswer History View from NirSoft.net
echo Collecting broswer history
browsinghistoryview\BrowsingHistoryView.exe /scomma "%resultsDir%\broswer-history.csv"


REM Collect dns data | dnsdataviewer from NirSoft
echo Collecting dns data
ipconfig /displaydns > "%resultsDir\dnsdata.txt"
REM There is an issue with the above block of code. It creates the file but it is empty.


REM Collect Open Files from Open Files Viewer from NirSoft
echo Collecting open files
ofview-x64\OpenedFilesView.exe  /stext "%resultsDir%\open-files.txt"
REM There is an issue with the above block of code. It creates the file but it is empty.


REM Collect | from winprefetch from NirSoft
echo Collecting WinPrefetch
winprefetchview-x64\WinPrefetchView.exe /scomma "%resultsDir%\winprefetch.csv"


REM Collect PSList and PSInfo
echo Collecting PSList & PSInfo
PSTools\pslist.exe -t > "%resultsDir%\pslist.txt"
PSTools\psinfo.exe -h -s > "%resultsDir%\psinfo.txt"



echo All Done.
