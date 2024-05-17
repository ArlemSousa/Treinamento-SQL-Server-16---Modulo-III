
Exec msdb.dbo.SP_send_dbmail
@Profile_name = 'DBA',
@Recipients = 'escrever um e-mail que possa ser aberto',
@Body = 'Teste enviado pelo SQL Server 2016',
@Subject = 'Mensagem enviada com sucesso'
