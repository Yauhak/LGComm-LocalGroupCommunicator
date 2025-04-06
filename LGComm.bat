@echo off
net use X: /delete
cls
set my_name=Hk.C
if not exist D:\dialog\1.txt (
   md D:\dialog
   echo [Dialog]> D:\dialog\1.txt
)
net share log
cls
if not %errorlevel% == 0 (
   net share log=D:\dialog
   cls
)
echo Welcome to LGComm (Local_Group Communicatior)!
echo Copyright@Yauhak Chen (CYH)
echo 2022/2/3,forever.
:ip
set /p lg_ip=Input IP Address:
ping %lg_ip%
cls
if not %errorlevel% == 0 (
   if not %errorlevel% == 1 (
      echo Error code:%errorlevel%
      echo Oops!Here has been some errors with your network! :-(
      set /p exit =Please press [Enter] to continue...
      exit
   ) else (
     echo Maybe you gave a wrong IP address?
     goto ip
   )
)
net use X: \\%lg_ip%\log
cls
if not %errorlevel% == 0 (
   echo Error code:%errorlevel%
   echo Fail to connect! :-(
   set /p exit =Please press [Enter] to continue...
   exit
)
:start
   type D:\dialog\1.txt
   set /p "for_send=::::"
   if "%for_send%" == "exit" (
      net use X: /delete
      exit
   )
   if NOT "%for_send%" == "" (
      copy X:\1.txt D:\dialog\1.txt
      echo ::[%my_name%]%date% %time%:: %for_send% >D:\dialog\2.txt
      set "for_send="
      copy D:\dialog\1.txt /a + D:\dialog\2.txt /b = D:\dialog\1.txt
      del /f /s /q D:\dialog\2.txt
   ) else (
      copy X:\1.txt D:\dialog\1.txt
   )
   cls
goto start