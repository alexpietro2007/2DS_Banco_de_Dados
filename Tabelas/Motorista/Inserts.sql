--INSERTS
USE db_Veiculo

CREATE PROCEDURE inserir_Motorista 
	@nomeMotorista VARCHAR(100),
	@dataNasc SMALLDATETIME,
	@cpf VARCHAR(11),
	@cnh VARCHAR(9),
	@pontVerificada INT 
AS
BEGIN

	IF EXISTS (SELECT cnhMotorista FROM tbl_Motorista
				WHERE cnhMotorista = @cnh)
	BEGIN
		PRINT 'Motorista já cadastrado'
	END ELSE
	BEGIN
		INSERT INTO tbl_Motorista(nomeMotorista, dataNascMotorista,cpfMotorista, cnhMotorista, pontuaçãoVerificada)VALUES
		(@nomeMotorista, @dataNasc, @cpf, @cnh, @pontVerificada)
	END
END

EXEC inserir_Motorista 'alex', '30/08/2007', '55834660819', '123456123',0
EXEC inserir_Motorista 'rafael', '15/05/1990', '55834871234', '987654321', 0;
EXEC inserir_Motorista 'julia', '22/11/1985', '55834985678', '654321987', 0;
EXEC inserir_Motorista 'marta', '05/01/1995', '55834123456', '456123789', 0;
EXEC inserir_Motorista 'pedro', '10/10/1980', '55834234567', '321654987', 0;
EXEC inserir_Motorista 'lucas', '03/07/1988', '55834345678', '789456123', 0;

CREATE PROCEDURE inserir_Veiculo 
	@modelo VARCHAR(80),
	@placa VARCHAR(7),
	@renavam VARCHAR(11),
	@ano SMALLDATETIME,
	@idMotorista INT
AS
BEGIN
	
	IF EXISTS (SELECT placa FROM tbl_Veiculo
				WHERE placa = @placa)
	BEGIN 
		PRINT 'Carro já Cadastrado'
	END ELSE
	BEGIN
		INSERT INTO tbl_Veiculo(modeloVeiculo, Placa, renavam, anoVeiculo, idMotorista)VALUES
		(@modelo, @placa, @renavam, @ano, @idMotorista)
	END
END

EXEC inserir_Veiculo 'Fiat Uno', '1233527', '12345678998', '2007', 1;
EXEC inserir_Veiculo 'Ford Fiesta', '1233528', '12345678999', '2010', 2;
EXEC inserir_Veiculo 'Chevrolet Onix', '1233529', '12345678001', '2015', 3;
EXEC inserir_Veiculo 'Volkswagen Gol', '1233530', '12345678002', '2018', 4;
EXEC inserir_Veiculo 'Hyundai HB20', '1233531', '12345678003', '2020', 5;
EXEC inserir_Veiculo 'Renault Kwid', '1233532', '12345678004', '2022', 6;


CREATE PROCEDURE inserirMulta
	@data SMALLDATETIME,
	@hora SMALLDATETIME,
	@pontosMulta INT,
	@idVeiculo INT
AS
BEGIN




END