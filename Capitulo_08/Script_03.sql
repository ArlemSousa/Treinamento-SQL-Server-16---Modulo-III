--------------------------------------------------------
BACKUP DATABASE SuperMercado
TO BackupSuperMercado
WITH
DESCRIPTION = 'Backup Full do Database SuperMercado',
INIT,
MEDIANAME = 'Backup SuperMercado',
NAME = 'Backup Full SuperMercado' 
--------------------------------------------------------
BACKUP DATABASE SuperMercado
TO BackupSuperMercado
WITH
DIFFERENTIAL,
DESCRIPTION = 'Backup Diferencial do database SuperMercado',
NOINIT,
MEDIANAME = 'Backup SuperMercado',
NAME = 'Backup Diferencial SuperMercado'
--------------------------------------------------------
BACKUP LOG SuperMercado
TO BackupSuperMercado
WITH
DESCRIPTION = 'Backup Log do Database SuperMercado',
NOINIT,
MEDIANAME = 'Backup SuperMercado',
NAME = 'Backup Log SuperMercado'
--------------------------------------------------------
