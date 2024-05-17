
Use Master
go

IF EXISTS(SELECT * FROM Master.dbo.Sysdatabases
                    WHERE Name LIKE '%Siscom%')
         DROP DATABASE Siscom
		 
go

-- houver ela será criada
DECLARE @result int
EXEC @result = xp_cmdshell 'dir C:\Bancos'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos'


EXEC @result = xp_cmdshell 'dir C:\Bancos\siscom'
IF (@result <> 0)
   Exec master.dbo.xp_cmdshell 'MD C:\Bancos\siscom'
go


CREATE DATABASE Siscom
ON PRIMARY
(
  name  =  'Siscom_Dados1',
  filename   =  'C:\Bancos\Siscom_Dados1.mdf',
  size = 10MB,
  maxsize= 100MB,
  filegrowth = 10MB
),
FILEGROUP TABELAS
(
  name  =  'Siscom_Dados2',
  filename   =  'C:\Bancos\Siscom_Dados2.ndf',
  size = 10MB,
  maxsize= 100MB,
  filegrowth = 10MB
),
FILEGROUP INDICES
(
  name  =  'Siscom_Dados3',
  filename   =  'C:\Bancos\Siscom_Dados3.ndf',
  size = 10MB,
  maxsize= 100MB,
  filegrowth = 10MB
)
LOG ON
(
  name  =  'Siscom_Log',
  filename   =  'C:\Bancos\Siscom_Log.ldf',
  size = 10MB,
  maxsize= 100MB,
  filegrowth = 10MB
)
go
/* ********************************************************************** */
USE Siscom
go
Exec SP_AddType 'Codigo', int, 'not null'
Exec SP_AddType 'Nome', 'varchar(100)', 'not null'
Exec SP_AddType 'Moeda','decimal(10,2)','not null'
Exec SP_AddType 'Sexo', 'char(01)','not null'
Exec SP_AddType 'DDD', 'char(03)', 'not null'
Exec SP_AddType 'Fone','char(10)', 'not Null'
Exec SP_AddType 'RG','char(15)', 'not null'
Exec SP_AddType 'CPF','char(20)','not null'
Exec SP_AddType 'Data','smalldatetime','not null'
Exec SP_AddType 'Valor','decimal(10,2)','not null'
go
/* ********************************************************************** */
CREATE RULE R_Moeda
AS @moeda >= 200.00
go
CREATE RULE R_Sexo
AS @sexo IN ('F','M')
go
/* ********************************************************************** */
CREATE DEFAULT D_Moeda
AS 200.00
go
CREATE DEFAULT D_Sexo
AS 'F'
go
/* ********************************************************************** */
Exec SP_BindRule 'R_Moeda','Moeda'

Exec SP_BindRule 'R_Sexo','Sexo'

Exec SP_Bindefault 'D_Moeda','Moeda'

Exec SP_Bindefault 'D_Sexo','Sexo'
go
/* ********************************************************************** */
CREATE TABLE TipoFone
(
  Cod_TipoFone      int     Identity       Not Null,
  Nome_TipoFone   char(50)              Not Null,

  Constraint PK_Fone Primary Key(Cod_TipoFone),
  Constraint UQ_Fone Unique(Nome_TipoFone)
)ON TABELAS
go
INSERT TipoFone VALUES('Residencial')
INSERT TipoFone VALUES('Comercial')
INSERT TipoFone VALUES('Recado')
INSERT TipoFone VALUES('Celular')
go
/* ********************************************************************** */
CREATE TABLE TipoProd
(
  Cod_TipoProd     int Identity Not Null,
  Nome_TipoProd  char(50)   Not Null,

  Constraint PK_Prod Primary Key(Cod_TipoProd),
  Constraint UQ_TipoProd Unique(Nome_TipoProd)
)ON TABELAS
go
INSERT TipoProd VALUES('Especial')
INSERT TipoProd VALUES('Classico')
INSERT TipoProd VALUES('Normal')
INSERT TipoProd VALUES('Revisado')
INSERT TipoProd VALUES('Reciclado')
go
/* ********************************************************************** */
CREATE TABLE Cliente
(
  Cod_Cli            Codigo Identity,
  Nome_Cli         Nome,
  Renda_Cli        Moeda,
  Data_NascCli  Data,
  Sexo_Cli           Sexo,
  Constraint PK_Cli Primary Key(Cod_Cli)
)ON TABELAS
go
INSERT Cliente VALUES('Olga Cristina Bonfiglioli',240.00,Getdate(),'F')
INSERT Cliente VALUES('Maria Cristina Bonfiglioli Martins de Souza Santos',240.00,Getdate(),'F')
INSERT Cliente VALUES('Salvador Eneas Feredico',240.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Dolores Gerreiro Martins',240.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Fabiana Bataglin',240.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Aparecida Ribeiro',240.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Reginaldo Ribeiro',240.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Suellen M Nunes',240.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Carlos Alberto',240.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Roberto Arruda',240.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Sandra Medeiros',240.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Alice Santos',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Valter Sanches',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Pascoal Babiera',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Lucia Bacalla',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Maria Belido',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Hamilton Belico',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Alberto Belli',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Marcia Bueno',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Maria Catta',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Carlos Cattaneo',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Andre Caula',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Fabia Dávello',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Afonso Ferraro',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Akemi Fukamizu',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Bernadino Gomes',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Regiani Hoki',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Valter Koszura',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Alexandre Kozeki',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Vittorio Lannocca',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Domingos Lanini',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Paulo Mello',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Zilda Mellone',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Marlene Moura',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Francisca Oliveira',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Marlene Pereira',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Milton Pereira',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Ligia Ramos',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Mariangela Ramos',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Dora Romariz',100.00 * @@Identity,Getdate(),'F')
INSERT Cliente VALUES('Paulino Romelli',1000.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Fernando Sampaio',1000.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('José Sampaio',1000.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Vicenzo Senatori',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Geraldo Senedeze',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Mauro Soares',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Paulo Souza',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Emidio Trifoni',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Heitor Vernile',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Carlos Saura',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Angelino Saullo',100.00 * @@Identity,Getdate(),'M')
INSERT Cliente VALUES('Aldo Savazzoni',100.00 * @@Identity,Getdate(),'M')
go
/* ******************************************************************/
UPDATE Cliente
SET Data_NascCli = 
     Convert(Smalldatetime, Convert (Char(2),DatePart(mm,'01/01/01')) + '/' +
     Convert(char(2),DatePart(dd,'01/01/01'))+ '/' +
     Convert(Char(4),DatePart(yy,'01/01/01') - Cod_Cli - 30))
go
/* ********************************************************************** */
CREATE TABLE Conjuge
(
  Cod_Cli            Codigo, 
  Nome_Conj     Nome,
  Renda_Conj    Moeda,
  Sexo_Conj      Sexo,
  Constraint PK_Conj Primary Key(Cod_Cli),
  Constraint FK_Conj Foreign Key (Cod_Cli) References Cliente(Cod_Cli)
)ON TABELAS
go
/* voce insere conjuge para os 5 primeiros clientes */
/* ********************************************************************** */
CREATE TABLE Fone
(
   Cod_Fone                Codigo Identity,
   Cod_TipoFone        Codigo,
   Cod_Cli                    Codigo,
   Num_Fone              Fone,
   DDD_Fone              DDD,
   Constraint PK_F Primary Key(Cod_Fone),
   Constraint FK_F_1 Foreign Key(Cod_TipoFone) References TipoFone(Cod_TipoFone),
   Constraint FK_F_2 Foreign Key(Cod_Cli) References Cliente(Cod_Cli)
) ON TABELAS
go
INSERT Fone VALUES(1,1,'434-2356','011')
INSERT Fone VALUES(2,1,'256-4578','011')
INSERT Fone VALUES(3,1,'256-5623','011')
INSERT Fone VALUES(4,2,'242-9865','011')
INSERT Fone VALUES(1,2,'323-8945','011')
INSERT Fone VALUES(2,2,'232-7845','011')
INSERT Fone VALUES(3,3,'565-2365','011')
INSERT Fone VALUES(4,3,'454-1254','011')
INSERT Fone VALUES(1,3,'898-2345','011')
INSERT Fone VALUES(2,4,'454-1223','011')
INSERT Fone VALUES(3,4,'787-4512','011')
INSERT Fone VALUES(4,5,'525-4578','011')
INSERT Fone VALUES(1,5,'252-9887','011')
INSERT Fone VALUES(2,6,'578-6521','011')
INSERT Fone VALUES(3,6,'568-5421','011')
INSERT Fone VALUES(1,8,'568-2154','011')
INSERT Fone VALUES(1,9,'587-3221','011')
INSERT Fone VALUES(1,10,'863-6598','011')
INSERT Fone VALUES(1,11,'138-8754','011')
INSERT Fone VALUES(2,12,'123-6598','011')
INSERT Fone VALUES(2,13,'321-6357','011')
INSERT Fone VALUES(2,14,'301-1232','011')
INSERT Fone VALUES(2,15,'321-4512','011')
INSERT Fone VALUES(3,16,'333-3221','011')
INSERT Fone VALUES(3,17,'555-4578','011')
INSERT Fone VALUES(3,18,'666-1245','011')
INSERT Fone VALUES(3,19,'777-3265','011')
INSERT Fone VALUES(4,20,'888-2154','011')
INSERT Fone VALUES(4,21,'999-1111','015')
INSERT Fone VALUES(4,21,'202-1222','015')
INSERT Fone VALUES(4,22,'254-3333','015')
INSERT Fone VALUES(1,23,'458-4444','015')
INSERT Fone VALUES(1,23,'874-5555','015')
INSERT Fone VALUES(1,24,'313-6666','015')
INSERT Fone VALUES(1,24,'587-7777','015')
INSERT Fone VALUES(2,25,'589-8888','015')
INSERT Fone VALUES(2,26,'999-9999','015')
INSERT Fone VALUES(2,27,'999-1010','015')
INSERT Fone VALUES(2,27,'111-1111','015')
INSERT Fone VALUES(3,28,'222-1212','015')
INSERT Fone VALUES(3,28,'333-1313','015')
INSERT Fone VALUES(3,28,'444-1414','015')
INSERT Fone VALUES(3,29,'555-1515','015')
INSERT Fone VALUES(4,29,'666-1616','015')
INSERT Fone VALUES(4,30,'777-1717','015')
INSERT Fone VALUES(4,31,'888-1818','015')
INSERT Fone VALUES(4,32,'999-1919','015')
INSERT Fone VALUES(4,33,'101-2020','015')
INSERT Fone VALUES(4,34,'555-2121','021')
INSERT Fone VALUES(4,35,'333-2222','021')
INSERT Fone VALUES(4,36,'717-2323','021')
INSERT Fone VALUES(3,37,'656-2424','021')
INSERT Fone VALUES(3,38,'374-2525','021')
INSERT Fone VALUES(3,39,'859-2626','021')
INSERT Fone VALUES(3,40,'222-2727','021')
INSERT Fone VALUES(3,41,'256-2828','021')
INSERT Fone VALUES(3,42,'542-2929','021')
INSERT Fone VALUES(2,43,'578-3030','021')
INSERT Fone VALUES(2,44,'896-4041','021')
INSERT Fone VALUES(2,45,'369-5050','021')
INSERT Fone VALUES(2,46,'132-5151','021')
INSERT Fone VALUES(1,47,'321-6161','021')
INSERT Fone VALUES(1,48,'542-7171','011')
INSERT Fone VALUES(1,49,'201-8181','011')
INSERT Fone VALUES(1,50,'301-9191','011')
INSERT Fone VALUES(1,50,'401-1919','011')
INSERT Fone VALUES(1,50,'501-1818','011')
INSERT Fone VALUES(1,51,'601-1212','011')
INSERT Fone VALUES(1,52,'701-1313','011')
go
/* ********************************************************************** */
CREATE TABLE Funcionario
(
   Cod_Func          Codigo Identity,
   Nome_Func       Nome,
   Data_CadFunc  Data not null Default Getdate(),
   SexoFunc            Sexo,
   Sal_Func            Moeda,
   End_Func           varchar(100)  not null,
   Constraint PK_Func Primary Key(Cod_Func)
) ON TABELAS
go
INSERT Funcionario VALUES('Antonio Antonino Antones','01/02/00','M',1500.00,'Rua A	')
INSERT Funcionario VALUES('Amaro Merico Vespucio','02/02/00','M',2500.00,'Rua B')
INSERT Funcionario VALUES('Abílio Abel Garcia','03/02/01','M',1000.00,'Rua C')
INSERT Funcionario VALUES('Bia Bianca Bones','04/03/01','F',5000.25,'Rua D')
INSERT Funcionario VALUES('Beatriz Bertioga','05/05/01','F',300.00,'Rua E')
INSERT Funcionario VALUES('Caio Cesar Cearez','06/05/01','M',250.00,',Rua F')
INSERT Funcionario VALUES('Celso Cesare','07/06/01','M',1542.36,'Rua J')
INSERT Funcionario VALUES('Danilo Douglas','08/06/01','M',1524.56,'Rua K')
INSERT Funcionario VALUES('Denis Denilo','09/07/01','M',5235.56,'Rua L')
INSERT Funcionario VALUES('Everton Evaristo','10/07/01','M',2542.25,'Rua M')
INSERT Funcionario VALUES('Evanir Eva','11/08/01','M',4523.54,'Rua N')
INSERT Funcionario VALUES('Fabio Fabricio','12/08/01','M',1524.25,'Rua O')
INSERT Funcionario VALUES('Fabiola Fabiolo','02/01/02','F',2554.25,'Rua P')
INSERT Funcionario VALUES('Geraldo Gomes','03/010/02','M',1542.25,'Rua Q')
INSERT Funcionario VALUES('Helio Heliópolis','04/01/02','M',1542.23,'Rua R')
INSERT Funcionario VALUES('Irineu Irene','05/02/02','M',2523.00,'Rua S')
INSERT Funcionario VALUES('Jonas jackes','05/02/02','M',2500.00,'Rua T')
INSERT Funcionario VALUES('Leandro Lago','06/02/02','M',1500.00,'Rua U')
INSERT Funcionario VALUES('Lucio Lacio','07/03/02','M',2500.00,'Rua V')
INSERT Funcionario VALUES('Lecio Licio','08/04/02','M',1420.00,'Rua X')
INSERT Funcionario VALUES('Mario Mendes','06/02/02','M',1262.00,'Rua W')
INSERT Funcionario VALUES('Olavo Odavlas','07/07/02','M',1540.00,'Rua Y')
go
/* ********************************************************************* */
CREATE TABLE Dependente
(
   Cod_Dep                Codigo   Identity,
   Cod_Func              Codigo,
   Nome_Dep            Nome,
   Sexo_Dep               Sexo,
   Data_NascDep      Data,
   Constraint PK_Dep Primary Key(Cod_Dep),
   Constraint FK_Dep Foreign Key (Cod_Func) References Funcionario(Cod_Func)
) ON TABELAS
go
/*inserir 3 dependentes para o funcionario 1
inserir 2 dependentes para o funcionario 2
inserir 1 dependentes para o funcionario 3*/
/* ********************************************************************** */
CREATE TABLE Premio
(
   Cod_Premio       Codigo Identity,
   Cod_Func           Codigo,
   Data_Premio      Data,
   Val_Premio        Valor,
   Status_Premio   char(1),

   Constraint PK_Premio Primary Key(Cod_Premio),
   Constraint FK_Premio Foreign Key(Cod_Func) References Funcionario(Cod_Func),
   Constraint CH_Premio Check(Status_Premio IN ('0','1'))
) ON TABELAS
go
/* ********************************************************************** */
CREATE TABLE Pedido
(
  Num_Ped   Codigo identity  not null,
  Cod_Cli       Codigo              not null,
  Cod_Func   Codigo             not null,
  Data_Ped    Data                  not null,
  Val_Ped      Valor not null,
  Constraint PK_Ped  Primary Key(Num_Ped),
  Constraint FK_Ped1 Foreign Key(Cod_Cli) References Cliente(Cod_Cli),
  Constraint FK_Ped2 Foreign Key(Cod_Func) References Funcionario(Cod_Func)
) ON TABELAS
go
/* ******************************************************************/
CREATE PROCEDURE P_EnchePedido
AS
DECLARE @Cod_Func int,
                    @Cod_Cli    int,
                    @Cod_Sta   int,
                    @Data Varchar(255),
                    @DataPed smalldatetime,
                    @Valor  decimal(10,2)
SET @Cod_Func = 1
SET @Cod_Cli = 1
SET @Cod_Sta = 1

WHILE @Cod_Func <= 20
BEGIN
   WHILE @Cod_Cli < 50
   BEGIN   
                  SET @Data = CONVERT(Char(02),MONTH(DATEADD(mm,@Cod_Sta*2,Getdate())))
                  SET @Data = @Data + '/' + CONVERT(Char(02),DAY(GETDATE() -@Cod_Sta*3))
                  SET @Data = @Data + '/' + CONVERT(Char(04),YEAR(DATEADD(YY,-1*@Cod_Sta,GETDATE())))

                  SET @DataPed = Convert(smalldatetime,@Data)

                  SET @Valor =  @Cod_Func * 10

	      IF @Valor <= 240.00
                      SET @Valor = 300.00                	                      
	
                  INSERT Pedido VALUES(@Cod_Cli,@Cod_Func,@Data,@Valor)

                  SET @Cod_Sta = @Cod_Sta + 1
   
                  SET @Cod_Cli = @Cod_Cli + 1
                 SET @Cod_Sta = 1
    END

   SET @Cod_Func = @Cod_Func + 1
   SET @Cod_Cli = 1
END
go
/* ********************************************************************** */
Exec P_EnchePedido
go
/* ********************************************************************** */
CREATE TABLE Produto
(
  Cod_Prod          int identity        not null,
  Cod_TipoProd  int                     not null,
  Nome_Prod      varchar(100)   not null,
  Qtd_Estq           int                     not null ,
  Val_Unit           valor  not null,
  Constraint PK_Produto  Primary Key(Cod_Prod),
  Constraint FK_Produto  Foreign Key(Cod_TipoProd) References TipoProd(Cod_TipoProd),
  Constraint UQ_Produto  Unique(Nome_Prod)
)
go
INSERT Produto VALUES (1,'Caderno',10,1.25)
INSERT Produto VALUES (1,'Lapis',1,0.25)
INSERT Produto VALUES (1,'Borracha',7,2.00)
INSERT Produto VALUES (1,'Caneta',5,0.50)
INSERT Produto VALUES (1,'Cama',6,100.00)
INSERT Produto VALUES (1,'Cadeira',3,30.00)
INSERT Produto VALUES (2,'Guarda-Roupa',2,1200.00)
INSERT Produto VALUES (2,'Geladeira',2,3000.00)
INSERT Produto VALUES (2,'TV',6,300.00)
INSERT Produto VALUES (3,'Comida',7,15.00)
INSERT Produto VALUES (3,'Bebida',2,1.00)
go
/* ********************************************************************** */
CREATE TABLE Itens
(
   Num_Ped  Codigo,
   Cod_Prod Codigo,
   Qtd_Prod  int,
   Val_Vend  Valor,
  Constraint PK_Itens Primary Key(Num_Ped,Cod_Prod),
  Constraint FK_Prod_1 Foreign Key (Num_Ped) References Pedido(Num_Ped),
  Constraint FK_Prod_2 Foreign Key (Cod_Prod) References Produto(Cod_Prod)
)
go
/* ********************************************************************** */
INSERT Itens
SELECT Pedido.Num_Ped,
                Produto.Cod_Prod,
                Case
                  when Cod_Prod - Num_Ped / 100 < 0 Then 1
                  when Cod_Prod - Num_Ped / 100 = 0 Then 2
                  else Cod_Prod - Num_Ped / 100 
                End,
                Case 
                      when Val_Ped - Num_Ped < 0 Then (Val_Ped - Num_Ped) * -1
                      when Val_Ped - Num_Ped > 100 Then Num_Ped 
                       else Val_Ped - Num_Ped
                end
FROM Pedido CROSS JOIN Produto
WHERE Produto.Cod_Prod <= 10
go
/* ********************************************************************** */
DROP PROCEDURE P_EnchePedido
go
SELECT * FROM TipoFone
SELECT * FROM TipoProd
SELECT * FROM Cliente
SELECT * FROM Conjuge
SELECT * FROM Fone
SELECT * FROM Funcionario
SELECT * FROM Dependente
SELECT * FROM Premio
SELECT * FROM Pedido
SELECT * FROM Produto
SELECT * FROM Itens
go
/* ********************************************************************** */


