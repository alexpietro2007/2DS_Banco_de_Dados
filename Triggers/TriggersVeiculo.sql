USE db_Veiculo

CREATE TRIGGER tgMultaAtualizaMulta
ON tbl_Multas FOR INSERT 
AS BEGIN
	DECLARE 
	@idVeiculo INT,
	@idMotorista INT,
	@Multa INT,
	@pontVerif INT,
	@nome VARCHAR (70)

	SET @idVeiculo = (SELECT idVeiculo FROM INSERTED)
	SET @Multa = (SELECT pontosMulta FROM INSERTED)
	SET @idMotorista = (SELECT idMotorista FROM tbl_Veiculo 
						WHERE idVeiculo = @idVeiculo)
	SET @nome = (SELECT nomeMotorista FROM tbl_Motorista 
					WHERE idMotorista = @idMotorista)
	UPDATE tbl_Motorista SET
		pontuaçãoVerificada = pontuaçãoVerificada + @Multa
		WHERE idMotorista = @idMotorista

	SET @pontVerif = (SELECT pontuaçãoVerificada FROM tbl_Motorista
						WHERE idMotorista = @idMotorista)
	IF (@pontVerif >= 20)
	BEGIN
		PRINT 'Carteira do Motorista ' + @nome + ' Já pode Ser Apreendida Pois esta com: '+@pontVerif+' Pontos Na Carteira'
	END
END