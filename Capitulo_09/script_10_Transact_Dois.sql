Select @@ServerName
go
Use BancoTransact_Dois
go
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(6,default,'Globo',5,120.00)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(7,default,'CD',1000,1.50)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat)VALUES(8,default,'Lapiseira',15,0.50)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(9,default,'Tinteiro',20,3.50)
INSERT Material (Cod_Mat,Nome_Server,Nome_mat,Qtd_Mat,Val_Mat) VALUES(10,default,'Porta Caneta',25,1.20)
go
Exec SP_Help Material
go
SELECT * FROM Material