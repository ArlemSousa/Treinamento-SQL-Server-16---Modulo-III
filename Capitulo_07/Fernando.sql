
--Conexão para dominio\Fernando

Use Impacta
go
SELECT USER
go
CREATE TABLE NF
(
  Num_NF	int	,
  Val_NF	decimal(10,2),
  Data_NF	smalldatetime
)
go
CREATE TABLE Fatura
(
	Num_Fat int,  
    Cod_Cli	int,
	Num_NF	int,
    Data_Fat smalldatetime,
    Val_Fat	 decimal(10,2)
)
go
