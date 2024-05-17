--- Depois de Configurar o Mirroring
Use Ginasio
go
INSERT Esporte VALUES(6,'Atletismo')
INSERT Esporte VALUES(7,'Remo')
INSERT Esporte VALUES(8,'Futebol de Salão')
INSERT Esporte VALUES(9,'Voley')
INSERT Esporte VALUES(10,'Voley de Praia')
go
SELECT * FROM Esporte
go
WAITFOR DELAY '00:00:15'
go
INSERT Esporte VALUES(11,'Tênis')
INSERT Esporte VALUES(12,'Ping Pong')
INSERT Esporte VALUES(13,'Salto com Vara')
INSERT Esporte VALUES(14,'Ginástica Olímpica')
INSERT Esporte VALUES(15,'Ginástica Aeróbica')
go
SELECT * FROM Esporte
go
UPDATE Esporte
SET Nome_Esp = 'Ginástica Aeróbica'
WHERE cod_Esp = 15