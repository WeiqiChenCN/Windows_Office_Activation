@cls
@echo off

fsutil>nul
if errorlevel 1 (
  echo ���Թ���ԱȨ�����б��ű���
  echo PS���Ҽ������ű�����������Թ���Ա������У�A������
  pause>nul
  exit
)

::��������Խ���KMS������������ǵð�localhost�滻Ϊ��ķ�������ַ����Ŷ����
set KMS=localhost

ping -n 1 %KMS%>nul
if errorlevel 1 (
  echo KMS��������ʱ���ߣ��޷����
  echo ��ȷ��������ȷ������������ǳ��ֱ����������������
  pause>nul
  exit
)

echo ���ڼ���Windows�����Ժ� ...
cscript slmgr.vbs -skms %KMS%>nul
cscript slmgr.vbs -ato>nul

echo ���ڲ��Ұ�װ��Office������֮�����Ժ� ...
set success=false

setlocal enabledelayedexpansion
FOR /D %%I IN ("%ProgramFiles%\Microsoft Office\Office*" "%ProgramFiles(x86)%\Microsoft Office\Office*") DO (
  set OSPP="%%I\OSPP.VBS"
  IF EXIST !OSPP! (
    echo �ҵ���Offce��װ·��%%I�����ڼ��� ...
    cscript !OSPP! /sethst:%KMS%>nul
    cscript !OSPP! /act>nul
    set success=true
  )
)

if %success%==false (
  echo ��û���ҵ��κ�Microsoft Office��װ��
  echo ����Ҫ����Office��ֱ�Ӱ��س������ű���
  echo ����밲װ·�������硰C:\Program Files\Microsoft Office\Office16����

  set /p OSPP=

  set OSPP="!OSPP!\OSPP.VBS"
  IF EXIST !OSPP! (
    echo �ҵ�Office��װ��
    cscript !OSPP! /sethst:%KMS%>nul
    cscript !OSPP! /act>nul
  )
)

echo ������ɣ�
echo ����㷢��Windows��û������Ȱ�װ�ʺϵ���Կ��Ȼ����ʹ�ñ��ű���
echo ��װ��Կ�����cscript slmgr.vbs /ilc XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
echo ��Կ�����������ҵ���https://technet.microsoft.com/en-us/library/jj612867.aspx
echo ���κδ���������ʣ�����ϵ��weiqi_chen@outlook.com

pause>nul