--Tabelas

CREATE DATABASE db_Veiculo
GO
USE db_Veiculo

CREATE TABLE tbl_Motorista(
	idMotorista INT PRIMARY KEY IDENTITY(1,1),
	nomeMotorista VARCHAR(100) NOT NULL,
	dataNascMotorista SMALLDATETIME NOT NULL,
	cpfMotorista VARCHAR(11) NOT NULL,
	cnhMotorista VARCHAR(9) NOT NULL,
	pontuaçãoVerificada INT NOT NULL
)

CREATE TABLE tbl_Veiculo(
	idVeiculo INT PRIMARY KEY IDENTITY(1,1),
	modeloVeiculo VARCHAR(80) NOT NULL,
	placa VARCHAR(7) NOT NULL,
	renavam VARCHAR(11) NOT NULL,
	anoVeiculo SMALLDATETIME NOT NULL,
	idMotorista INT FOREIGN KEY REFERENCES tbl_Motorista(idMotorista) 
)

CREATE TABLE tbl_Multas(
	idMulta INT PRIMARY KEY IDENTITY(1,1),
	dataMulta SMALLDATETIME NOT NULL,
	horaMulta TIME NOT NULL,
	pontosMulta INT NOT NULL,
	idVeiculo INT FOREIGN KEY REFERENCES tbl_Veiculo(idVeiculo)
)

