CREATE DATABASE db_clinicaMedica;
USE db_clinicaMedica;

CREATE TABLE tbl_Especialidade(

	nome varchar (100) NOT NULL,
	numeroRegistro int PRIMARY KEY,
	publicoAlvo varchar(256) NOT NULL

);

CREATE TABLE tbl_Medico(

	nome varchar (100) NOT NULL,
	telefone varchar (13) NOT NULL,
	cep varchar (8) NOT NULL,
	rua varchar (256) NOT NULL,
	apto varchar (100) ,
	casa varchar (100) ,
	crm varchar (8) PRIMARY KEY,


);

CREATE TABLE tbl_Paciente(

	nome varchar (100) NOT NULL,
	cep varchar (8) NOT NULL,
	rua varchar (256) NOT NULL,
	apto varchar (100) ,
	casa varchar (100) ,
	telefone varchar (13) NOT NULL,
	numeroBeneficiario varchar (10) PRIMARY KEY,
	doencasPrevias varchar (100) ,
	medicamentosUsoContinuo varchar (100) 

);

CREATE TABLE tbl_Consulta(

	numeroConsulta int PRIMARY KEY,
	data date NOT NULL,
	hora int NOT NULL

);

CREATE TABLE tbl_Agendamento(

	numeroAgendamento int PRIMARY KEY,
	data date NOT NULL,
	hora int NOT NULL,
	queixa varchar (100) NOT NULL,
	gravidade varchar (50) NOT NULL
);

DROP TABLE Agendamento
DROP TABLE Especialidade

SELECT * FROM tbl_Medico;
SELECT * FROM tbl_Paciente;
SELECT * FROM tbl_Agendamento;
SELECT * FROM tbl_Consulta;
SELECT * FROM tbl_Especialidade;