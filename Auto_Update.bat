@ECHO OFF
IF "%1" == "h" GOTO begin
mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit
:begin
@ECHO OFF 
SET dd=%DATE:~0,10%
SET tt=%time:~0,8%
SET hour=%tt:~0,2%
SET ymd=%dd:/=-%
chcp 65001
TITLE =��ʱͬ������czipdata By A76YYYY
REM %DATE:~0,10%  2020/11/24
REM change file directory
CD /d %~dp0
REM �ж�logĿ¼�Ƿ���ڣ�����������򴴽�
SET logFolder=log
IF NOT EXIST %logFolder% (
REM  ����logĿ¼ ���ڵ�ǰλ�ô���logĿ¼��
ECHO %logFolder%Ŀ¼�����ڣ��Ѵ�����Ŀ¼��
MD %logFolder%
)
REM create log file
SET Log=log\Auto_Update_%ymd%.log
(
chcp 65001
ECHO =======================================================
ECHO          Starting automatic update ipdata
ECHO =======================================================
git pull origin main
python ./IP_Sync/ip_Sync.py
ECHO =======================================================
ECHO          Starting automatic git commit push
ECHO =======================================================

REM start git script 
ECHO %~dp0
git add .
git status -s
git commit -m "Auto Update %dd:/=-% %tt%"
git tag "v%dd:/=.%" -m "Auto Update %dd:/=-% %tt%"
git push origin main --tags
git push Gitee main --tags
)>"%Log%"