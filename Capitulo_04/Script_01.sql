/* 
1.	Crie uma pasta SISCOM em C:\Bancos
2.	Copie os arquivos Siscom_Data.MDF e Siscom_Log.LDF da pasta C:\SQLServer2014 - Módulo III\Capitulo_04 para c:\Bancos\SISCOM.
*/ 

EXEC SP_Attach_db 
 @dbname    = 'Siscom',   
 @filename1 = 'c:\Bancos\SISCOM\Siscom_Data.mdf',
 @filename2 = 'c:\Bancos\SISCOM\Siscom_Log.ldf'
go

