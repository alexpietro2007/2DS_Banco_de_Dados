CREATE DATABASE dbDoceria
go
USE dbDoceria

CREATE TABLE tbl_Cartegoria(
	codCartegoriaProduto INT PRIMARY KEY IDENTITY (1,1),
	nomeCartegoriaProduto VARCHAR (70) NOT NULL
)

CREATE TABLE tbl_Cliente(
	codCliente INT PRIMARY KEY IDENTITY (1,1),
	nomeCliente VARCHAR(70) NOT NULL,
	dataNascCliente DATE NOT NULL,
	ruaCLiente VARCHAR(70) NOT NULL,
	numCasaCliente INT NOT NULL,
	cepCliente CHAR(8) NOT NULL,
	bairroCliente VARCHAR(70) NOT NULL,
	cidadeCliente VARCHAR(70) NOT NULL,
	estadoCliente VARCHAR(2) NOT NULL,
	cpfCliente CHAR(11) NOT NULL,
	sexoCliente CHAR(2)
)

CREATE TABLE tbl_Produto(
	codProduto INT PRIMARY KEY IDENTITY (1,1),
	nomeProduto VARCHAR(70) NOT NULL,
	precoKiloProduto MONEY NOT NULL,
	codCartegoriaProduto INT FOREIGN KEY REFERENCES tbl_Cartegoria(codCartegoriaProduto)
)

CREATE TABLE tbl_Encomenda(
	codEncomenda INT PRIMARY KEY IDENTITY (1,1),
	dataEncomenda DATE NOT NULL,
	codCliente INT FOREIGN KEY REFERENCES tbl_Cliente(codCliente),
	valorTotalEncomenda MONEY NOT NULL,
	dataEntregaEncomenda DATE NOT NULL
)

CREATE TABLE tbl_ItensEncomenda(
	codItensEncomenda INT PRIMARY KEY IDENTITY (1,1),
	codEncomenda INT FOREIGN KEY REFERENCES tbl_Encomenda(codEncomenda),
	codProduto INT FOREIGN KEY REFERENCES tbl_Produto(codProduto),
	quantidadeKilos FLOAT NOT NULL,
	subTotal MONEY NOT NULL,
)