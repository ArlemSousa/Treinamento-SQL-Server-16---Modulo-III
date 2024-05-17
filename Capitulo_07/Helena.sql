
-- conexão para Dominio\Helena

Use Impacta
go
SELECT USER
go
CREATE TABLE Funcionario
(
  Cod_Func	int,
  Nome_Func	varchar(100)
)
go
CREATE TABLE Atributo
(
  Cod_Atrib	int	,
  Nome_Atrib varchar(100)
)
go
CREATE TABLE FuncAtrib
(
  Cod_Func	int,
  Cod_Atrib  int
)
go
