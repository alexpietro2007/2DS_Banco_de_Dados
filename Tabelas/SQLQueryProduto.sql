CREATE DATABASE db_Produtos;
USE db_produtos;

CREATE TABLE tabela (
	nomeProduto        varchar(50) PRIMARY KEY,
	fornecedor         varchar(50) NOT NULL,
	custo_Unitario     float NOT NULL,
	quantidade         numeric NOT NULL,
	percentualLucro    float NOT NULL 
);

INSERT INTO tabela (nomeProduto, fornecedor, custo_Unitario, quantidade, percentualLucro) VALUES
('Mesa', 'Fornecedor 1', 200.00, 30, 20),
('Pão', 'Fornecedor 1', 100.00, 50, 10),
('Teclado', 'Fornecedor 1', 50.00, 50, 3),
('Sofá', 'Fornecedor 1', 10.00, 100, 0.5),
('Cortina', 'Fornecedor 1', 150.00, 20, 0.12),
('Manteiga', 'Fornecedor 1', 250.00, 2, 40),
('Pano', 'Fornecedor 1', 300.00, 5, 9.33)

UPDATE tabela SET quantidade = 50 WHERE  nomeProduto = 'Mesa';
UPDATE tabela SET quantidade = 80 WHERE nomeProduto = 'Sofá';

DELETE FROM tabela WHERE nomeProduto = 'Manteiga';
DELETE FROM tabela WHERE nomeProduto = 'Pano';

SELECT * FROM tabela;

SELECT nomeProduto, quantidade FROM tabela;

ALTER TABLE tabela ADD preco_venda float ;
ALTER TABLE tabela DROP COLUMN preco_venda;

SELECT nomeProduto , ( custo_Unitario * percentualLucro) AS preco_venda FROM tabela

SELECT 'R$'+  cast(custo_Unitario as varchar(6)) AS custo_Unitario FROM tabela

UPDATE tabela SET preco_venda =  168 WHERE nomeProduto = 'Cortina';
UPDATE tabela SET preco_venda = 4200 WHERE nomeProduto = 'Mesa';
UPDATE tabela SET preco_venda = 1100 WHERE nomeProduto = 'Pão';
UPDATE tabela SET preco_venda = 15 WHERE nomeProduto = 'Sofá';
UPDATE tabela SET preco_venda = 200 WHERE nomeProduto = 'Teclado';


/* 
	preco_venda = custo_Unitario + percentualLucro

	OU

	preco_venda = (custo_Unitario * percentualLucro) + custo_Unitario
*/

/*

cast : aleterar o tipo do dado e só serve para a apresentação de dados

as == para

or == junto (and)
*/



