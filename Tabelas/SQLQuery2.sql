CREATE DATABASE db_Segunda_base
USE db_Segunda_base
CREATE TABLE tbl_aluno (
	matricula int,
	rg varchar(12 ) NOT NULL,
	cpf varchar(14) NOT NULL,
	nome varchar(100) NOT NULL,
	telefone varchar(14) NOT NULL,
	curso varchar(50) NOT NULL,
	unidade_escolar varchar(50) NOT NULL
	PRIMARY KEY(matricula)
)

INSERT INTO tbl_aluno (matricula, rg, cpf, nome, telefone, curso, unidade_escolar) VALUES
(10, '57.271.546-2', '224.987.269-41', 'Fernando Top', '(14)94743-2007', 'ADM', 'SM')

SELECT * FROM tbl_aluno --dql

CREATE DATABASE db_carro

USE db_carro

CREATE TABLE tbl_carro (
	placa varchar (8),
	marca varchar (20) not null,
	modelo varchar (20) not null,
	cor varchar (20) not null,
	ano int not null
	PRIMARY KEY (placa)
)

INSERT INTO tbl_carro VALUES
('BCD-7521', 'Ford', 'Fiesta', 'Preto', 1999)

select * from tbl_carro

//