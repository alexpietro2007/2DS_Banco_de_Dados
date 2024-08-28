CREATE DATABASE bdLivrariaBrasileira
GO
USE bdLivrariaBrasileira
------ Tabelas------
CREATE TABLE tbAutor(
	codAutor INT PRIMARY KEY IDENTITY (1,1)
	,nomeAutor VARCHAR (100) NOT NULL
)
CREATE TABLE tbGenero(
 codGenero INT PRIMARY KEY IDENTITY (1,1)
 ,nomeGenero VARCHAR (50) NOT NULL
)
CREATE TABLE tbEditora(
	codEditora INT PRIMARY KEY IDENTITY (1,1)
	,nomeEditora VARCHAR (50) NOT NULL
)
CREATE TABLE tbLivro(
	codLivro INT PRIMARY KEY IDENTITY (1,1)
	,nomeLivro VARCHAR (100) NOT NULL
	,numPaginas INT NOT NULL
	,codGenero INT FOREIGN KEY (codGenero) REFERENCES tbGenero (codGenero)
	,codAutor INT FOREIGN KEY (codAutor) REFERENCES tbAutor (codAutor)
	,codEditora INT FOREIGN KEY (codEditora) REFERENCES tbEditora (codEditora)
)