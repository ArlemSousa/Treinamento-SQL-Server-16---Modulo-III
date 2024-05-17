CREATE DATABASE BancoPerformance;

USE BancoPerformance;

CREATE TABLE tblErro(
    NumErroID BIGINT IDENTITY PRIMARY KEY,
    MensagemErro VARCHAR(100),
    CodErro INT,
    Linguagem INT
)

INSERT tblErro
select
    LEFT([Text],20),
    severity,
    language_id 
FROM Sys.messages


SELECT MensagemErro, CodErro
FROM  tblErro
WHERE codErro = 16

SELECT MensagemErro, CodErro
FROM  tblErro
WHERE MensagemErro LIKE 'a%'

SELECT *
FROM  tblErro
WHERE Linguagem > 1000