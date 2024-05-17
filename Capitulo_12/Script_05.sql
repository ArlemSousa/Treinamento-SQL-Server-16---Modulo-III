
-- Script_05
-- Log Shipping
-- No servidor PRIMÁRIO
CREATE DATABASE Escritorio
go
USE Escritorio
go
CREATE TABLE Pessoa
(
  Cod_Pes	int	Primary Key,
  Nome_Pes  varchar(100)
)
go
INSERT Pessoa VALUES(1,'Ana')
INSERT Pessoa VALUES(2,'Ciciliana')
INSERT Pessoa VALUES(3,'Diana')
INSERT Pessoa VALUES(4,'Eliana')
INSERT Pessoa VALUES(5,'Fabiana')
go
SELECT * FROM Pessoa
go
--------------------------------------------------------------------------

