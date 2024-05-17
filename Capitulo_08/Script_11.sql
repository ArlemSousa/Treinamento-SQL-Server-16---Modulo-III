/* *************************************************************************** */
-- Acessando o database Vendas
Use Vendas
go
/* *************************************************************************** */
-- Lendo o Conteúdo das tabelas
SELECT * FROM Funcionario
SELECT * FROM Pedido
SELECT * FROM Premio
/* *************************************************************************** */
--Dados para Teste
INSERT Pedido VALUES(2,getdate(),1500.00)

INSERT Pedido VALUES(4,getdate(),50.00)
INSERT Pedido VALUES(2,getdate(),100.00)
INSERT Pedido VALUES(4,getdate(),200.00)
INSERT Pedido VALUES(5,getdate(),300.00)
INSERT Pedido VALUES(4,getdate(),100.00)
INSERT Pedido VALUES(5,getdate(),50.00)
INSERT Pedido VALUES(2,getdate(),50.00)
INSERT Pedido VALUES(2,getdate(),2000.00)
INSERT Pedido VALUES(1,getdate(),3000.00)
/* *************************************************************************** */
/* *************************************************************************** */
SELECT * FROM Premio
/* *************************************************************************** */
/* *************************************************************************** */

