:: vim: set foldmethod=marker

:: assignment {{{

set var=value
set var=(value1 value2)
set var=

:: }}}
:: input {{{

set /p var="prompt text" %=%

:: }}}
:: identify OS language {{{

:: see this for all codes: https://msdn.microsoft.com/en-us/goglobal/bb895996.aspx
set wmicformat=csv
FOR /F "tokens=3 delims= " %%G in ('reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage') do (
    if [%%G]==[0409] (
      :: en-US
      :: do something
    )

:: }}}
:: for loop {{{

FOR %%a IN (val1 val2 val3 ...) DO op

FOR %%a IN (val1 val2 val3 ...) DO (
  ...
)

:: }}}
:: external batch {{{

:: execute another as internal commands (useful to setup variables)
call another.bat

:: execute another batch in another cmd
cmd /c another.bat

:: start in another window and wait until finished
start /wait cmd /c another.bat

:: }}}
:: choices/options {{{

ver>nul :: reset errorlevel
if '%errorlevel%'=='0' (
    choice /m "menu text" /c ABC
    :: must test in descending order
    IF ERRORLEVEL 3 goto :optionC
    IF ERRORLEVEL 2 goto :optionB
    IF ERRORLEVEL 1 goto :optionA
)
:optionA
echo "selected option A"
goto :after

:optionB
echo "selected option B"
goto :after

:optionC
echo "selected option C"
goto :after

:after

:: }}}
:: get invoking directory {{{

:: just execute this at the beginning of the script
:: useful for not exiting at another location
set invokingdir=%CD%

:: }}}
:: redirect output {{{

:: standart output
>
:: as in
echo blablabla > redirected.txt

:: error stream
2>
:: as in
del /Q /S * 2>nul :: will swallow errors into the abyss

:: supress everything
:: redirect stdout to nul, and stderr to stdout
del /Q /S *   >nul 2>&1

:: }}}
:: writing files {{{

:: simple way: just echo appending to file
echo Line 1 >  myfile.txt
echo Line 2 >> myfile.txt
:: and so on...

:: write with one redirection
(
  echo Line 1
  echo Line 2
  :: and so on...
) > myfile.txt

:: }}}
:: get current date/time {{{

for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set CurrentDate=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%
set year=%ldt:~0,4%
set month=%ldt:~4,2%
set day=%ldt:~6,2%

set CurrentTime=%ldt:~8,2%:%ldt:~10,2%:%ldt:~12,2%
set hours=%ldt:~8,2%
set minutes=%ldt:~10,2%
set seconds=%ldt:~12,2%

:: }}}
