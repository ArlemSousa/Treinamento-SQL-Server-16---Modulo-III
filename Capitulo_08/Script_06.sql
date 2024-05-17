alter database clientes
 add LOG file 
 (
   Name			='Clientes_Log1',
   Filename		='C:\BancoClientes\Clientes_Log.2df',
   Maxsize		= 100MB,
   Filegrowth	= 1%
  ) 

