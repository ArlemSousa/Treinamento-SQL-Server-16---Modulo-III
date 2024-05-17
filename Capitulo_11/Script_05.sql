Use Comercio
go
SELECT Cliente.Nome_Cli,
               Fone.Num_Fone,
            	 Funcionario.Nome_Func,
               Itens.Num_Ped,
               Itens.Cod_Prod,
               Itens.Val_Vend,
               Produto.Nome_Prod
FROM Cliente inner join Fone
ON Cliente.Cod_Cli = Fone.Cod_Cli
                         inner join Pedido
ON Cliente.Cod_Cli = Pedido.Cod_Cli
                         inner join Funcionario
ON Funcionario.Cod_Func = Pedido.Cod_Func
                         inner join Itens
ON Pedido.Num_Ped = Itens.Num_Ped
                         inner join Produto
ON Produto.Cod_Prod = Itens.Cod_Prod
            