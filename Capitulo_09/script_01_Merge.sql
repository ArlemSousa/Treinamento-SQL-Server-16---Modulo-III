
--- No Publisher
CREATE DATABASE BancoReplica
go
USE BancoReplica
go
CREATE TABLE Treinamento
(
  Cod_Trein int	Primary Key,
  Nome_Trein varchar(100)
)
go
INSERT Treinamento VALUES(1,'Microsoft SQL Server')
INSERT Treinamento VALUES(2,'Oracle')
INSERT Treinamento VALUES(3,'BD2')
INSERT Treinamento VALUES(4,'Sybase')
INSERT Treinamento VALUES(5,'PostgreSQL')
INSERT Treinamento VALUES(6,'MySQL')
go
