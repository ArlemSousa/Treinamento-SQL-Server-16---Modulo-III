Use Siscom
go

---------------Query_01
-- Execute os comandos abaixo:
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
go
-- Exiba todos os clientes que fizeram pedidos
SELECT Distinct Cliente.*
FROM Cliente inner join Pedido
ON Cliente.Cod_Cli = Pedido.Cod_Cli
go


---------------Query_02
-- Execute os comandos abaixo:
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
go
-- Exiba quantos pedidos cada cliente tem
SELECT Cliente.Cod_Cli,
                Cliente.Nome_Cli,
                Count(Pedido.Cod_Cli) AS Qtd_Ped
FROM Cliente inner join Pedido
ON Cliente.Cod_Cli = Pedido.Cod_Cli
GROUP BY Cliente.Cod_Cli,
         Cliente.Nome_Cli
go
-------------------------------------------------------


---------------Query_03
-- Execute os comandos abaixo:
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
go
-- Quantos dependentes cada funcionario possui
SELECT Funcionario.Cod_Func,
               Funcionario.Nome_Func,
               Count(Dependente.Cod_Func) AS Qtd_Dep
FROM Funcionario left join Dependente
ON Funcionario.Cod_Func = Dependente.Cod_Func
GROUP BY Funcionario.Cod_Func,
                     Funcionario.Nome_Func
go
-------------------------------------------------------


---------------Query_04
-- Mostre os detalhes dos pedidos de cada cliente
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
go
SELECT Pedido.Cod_Cli,
               Pedido.Num_Ped,
               Pedido.Data_Ped,
	 Pedido.Val_Ped,
	 Produto.Nome_Prod,
	 (ItensPedido.Qtd_Prod * ItensPedido.Val_Prod) AS Val_Item
FROM Pedido  inner join ItensPedido
ON Pedido.Num_Ped = ItensPedido.Num_Ped
	            inner join Produto
ON Produto.Cod_Prod = ItensPedido.Cod_Prod
go
--------------------------------------------------------

---------------Query_05
-- Mostre os detalhes do pedido 4837
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
go
SELECT Pedido.Cod_Cli,
               Pedido.Num_Ped,
               Pedido.Data_Ped,
	 Pedido.Val_Ped,
	 Produto.Nome_Prod,
	 (ItensPedido.Qtd_Prod * ItensPedido.Val_Prod) AS Val_Item
FROM Pedido  inner join ItensPedido
ON Pedido.Num_Ped = ItensPedido.Num_Ped
	            inner join Produto
ON Produto.Cod_Prod = ItensPedido.Cod_Prod
WHERE Pedido.Num_Ped = 4837
go
--------------------------------------------------------
