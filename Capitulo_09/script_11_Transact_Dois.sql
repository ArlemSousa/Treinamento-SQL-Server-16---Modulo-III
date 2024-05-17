SELECT @@servername
go
Use BancoTransact_Dois
go
SELECT * FROM Material
go
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(6,'Server Assinante','Lápis colorido',10,23.00)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(7,'Server Assinante','Pincel',12,12.00)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(8,'Server Assinante','Nanquim',2,22.00)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(9,'Server Assinante','Grampeador',10,50.00)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(10,'Server Assinante','Furador',40,35.00)
go
SELECT * FROM Material
go
Exec SP_Help Material