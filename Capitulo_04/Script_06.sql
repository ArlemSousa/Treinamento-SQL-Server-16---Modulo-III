Use Siscom
go
-- Colocando chaves primárias nas tabelas
ALTER TABLE Cliente
ADD Constraint PK_Cli Primary Key Clustered(Cod_Cli)
go
ALTER TABLE Funcionario
ADD Constraint PK_Func Primary Key Clustered(Cod_Func)
go
ALTER TABLE Dependente
ADD Constraint PK_Dep Primary Key Clustered(Cod_Dep)
go
ALTER TABLE Pedido
ADD Constraint PK_Ped Primary Key Clustered(Num_Ped)
go
ALTER TABLE Produto
ADD Constraint PK_Prod Primary Key Clustered(Cod_Prod)
go
ALTER TABLE ItensPedido
ADD Constraint PK_ItensPed
Primary Key Clustered(Num_Reg)
go
-- Colocando chaves estrangeiras nas tabelas
ALTER TABLE Pedido
WITH NOCHECK
ADD Constraint FK_Ped1 
Foreign Key(Cod_Cli)
References Cliente(Cod_Cli)
go
ALTER TABLE Pedido
ALTER COLUMN Cod_Func int not null
go
ALTER TABLE Pedido
WITH NOCHECK
ADD Constraint FK_Ped2
Foreign Key(Cod_Func)
References Funcionario(Cod_Func)
go
ALTER TABLE ItensPedido
ADD Constraint FK_ItensPed
Foreign Key (Cod_Prod)
References Produto(Cod_Prod)
go
ALTER TABLE ItensPedido
ADD Constraint FK_ItensPed2
Foreign Key (Num_Ped)
References Pedido(Num_Ped)
go
ALTER TABLE Dependente
Add Constraint FK_Dep
Foreign Key(Cod_Func)
References Funcionario(Cod_Func)
go

-- Colocado indices nas colunas que são
-- chaves estrangeiras nas tabelas
CREATE NONCLUSTERED INDEX I_Depend
ON Dependente(Cod_Func)
go
CREATE NONCLUSTERED INDEX I_ItensPed_1
ON ItensPedido(Num_Ped,Cod_Prod)
go
CREATE NONCLUSTERED INDEX I_ItensPed_2
ON ItensPedido(Cod_Prod,Num_Ped)
go
CREATE NONCLUSTERED INDEX I_ItensPed_3
ON ItensPedido(Num_Ped)
go
CREATE NONCLUSTERED INDEX I_ItensPed_4
ON ItensPedido(Cod_Prod)
go
CREATE NONCLUSTERED INDEX I_Ped_1
ON Pedido(Cod_Cli)
go
CREATE NONCLUSTERED INDEX I_Ped_2
ON Pedido(Cod_Func)
go



