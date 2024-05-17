
--Publicação Transacional -> Só envia os dados e não recebe nada
SELECT @@ServerName
go
CREATE DATABASE BancoTransact_Um
go
Use BancoTransact_Um
go
CREATE TABLE Material
(
  Cod_Mat		int				not null,
  Nome_Server	varchar(100)	not null default 'Server_Editor',
  Nome_Mat		varchar(100)	not null,
  Qtd_Mat		int				not null,
  Val_Mat		varchar(100)	not null,
  Primary Key(Cod_Mat,Nome_Server)
)  
go
INSERT Material VALUES(1,default,'Caderno',5,20.00)
INSERT Material VALUES(2,default,'Lápis',10,1.50)
INSERT Material VALUES(3,default,'Borracha',15,0.50)
INSERT Material VALUES(4,default,'Caneta',20,3.50)
INSERT Material VALUES(5,default,'Apontador',25,1.20)
go
SELECT * FROM Material
go
