CREATE DATABASE db_estoque
USE db_estoque

CREATE TABLE tbl_cliente(
	codCliente INT PRIMARY KEY IDENTITY(1,1),
	nomeCliente VARCHAR(250) NOT NULL,
	cpfCliente CHAR(11) NOT NULL,
	emailCliente VARCHAR(100) NOT NULL,
	sexoCliente CHAR(1) NOT NULL,
	dataNascimentoCliente DATE NOT NULL 
)

CREATE TABLE tbl_fabricante(
	codFabricante INT PRIMARY KEY IDENTITY(1,1),
	nomeFabricante VARCHAR(100) NOT NULL
)

CREATE TABLE tbl_fornecedor(
	codFornecedor INT PRIMARY KEY IDENTITY(1,1),
	nomeFornecedor VARCHAR(256) NOT NULL,
	contatoFornecedor CHAR(14) NOT NULL
)

CREATE TABLE tbl_venda(
	codVenda INT PRIMARY KEY IDENTITY(1,1),
	codCliente INT FOREIGN KEY REFERENCES tbl_cliente(codCliente),
	dataVenda DATE NOT NULL,
	valorTotalVenda MONEY NOT NULL,
)

CREATE TABLE tbl_produto(
	codProduto INT PRIMARY KEY IDENTITY (1,1),
	codFabricante INT FOREIGN KEY REFERENCES tbl_fabricante(codFabricante), 
	codFornecedor INT FOREIGN KEY REFERENCES tbl_fornecedor(codFornecedor),
	descricaoProduto VARCHAR (100) NOT NULL,
	valorProduto MONEY NOT NULL,
	quantidadeProduto INT NOT NULL,
)
	

CREATE TABLE tbl_itensVenda(
	codItensVenda INT PRIMARY KEY IDENTITY(1,1),
	codVenda INT FOREIGN KEY REFERENCES tbl_venda(codVenda),
	codProduto INT FOREIGN KEY REFERENCES tbl_Produto(codProduto),
	quantidadeItensVenda INT NOT NULL,
	subTotalItensVenda MONEY NOT  NULL
)

INSERT INTO tbl_cliente(nomeCliente, cpfCliente, emailCliente, sexoCliente,dataNascimentoCliente)VALUES
('Amanda José Santana', '12345678900', 'amandojsantana@outlook.com', 'm', '1961/02/21'),
('Sheila Carvalho Real', '45678909823', 'scarvalho@ig.com.br', 'f', '1978/09/13'),
('Carlos Henrique Souza', '76598278299', 'chenrique@ig.com.br', 'm', '1981/09/08'),
('Maria Aparecida Souza', '87365309899', 'mapdasouza@outlook.com', 'f', '1962/07/07'),
('Adriana Nogueira Silva', '76354309388', 'drica1977@ig.com.br', 'f', '1977/04/09'),
('Paulo Henrique Silva', '87390123111', 'phsilva@hotmail.com', 'm', '1987/02/02')

INSERT INTO tbl_fabricante(nomeFabricante)VALUES
('Unilever'),
('P&G'),
('Bunge')

INSERT INTO tbl_fornecedor(nomeFornecedor, contatoFornecedor)VALUES
('Atacadão', 'Carlos Santos'),
('Assai', 'Maria Stella'),
('Roldão', 'Paulo César')

INSERT INTO tbl_produto(descricaoProduto, valorProduto, quantidadeProduto, codFabricante, codFornecedor)VALUES
('Amaciante Downy', '5,56', '1500', '2', '1'),
('Amaciante Comfort', '5,45', '2300', '1', '1'),
('Sabão em pó OMO', '5,99', '1280', '1', '2'),
('Margarina Qually', '4,76', '2500', '3', '1'),
('Salsicha Hot Dog Sadia', '6,78', '2900', '3', '2'),
('Mortadela Perdigão', '2,50', '1200', '3', '3'),
('Hamburguer Sadia', '9,98', '1600', '3', '1'),
('Fralda Pampers', '36,00', '340', '2', '3'),
('Xampu Seda', '5,89', '800', '1', '1'),
('Condicionador Seda', '6,50', '700', '1', '3')

INSERT INTO tbl_venda(codCliente, dataVenda, valorTotalVenda)VALUES
('1', '01/02/2014', '4500'),
('1', '03/02/2014', '3400'),
('2', '10/02/2014', '2100'),
('3', '15/02/2014', '2700'),
('3', '17/03/2014', '560'),
('4', '09/04/2014', '1200'),
('5', '07/05/2014', '3500'),
('1', '07/05/2014', '3400'),
('2', '05/05/2014', '4000')

INSERT INTO tbl_itensVenda(codVenda ,codProduto, quantidadeItensVenda, subTotalItensVenda)VALUES
('1', '1', '200', '1500'),
('1', '2', '300', '3000'),
('2', '4', '120', '1400'),
('2', '2', '200', '1000'),
('2', '3', '130', '1000'),
('3', '5', '200', '2100'),
('4', '4', '120', '1000'),
('4', '5', '450', '700'),
('5', '5', '200', '560'),
('6', '7', '200', '600'),
('6', '6', '300', '600'),
('7', '1', '300', '2500'),
('7', '2', '200', '1000'),
('8', '6', '250', '1700'),
('8', '5', '200', '1700'),
('9', '4', '1000', '4000')

SELECT * FROM tbl_cliente
SELECT * FROM tbl_fabricante
SELECT * FROM tbl_fornecedor
SELECT * FROM tbl_itensVenda
SELECT * FROM tbl_produto
SELECT * FROM tbl_venda

--a) Listar as descrições dos produtos ao lado do nome dos fabricantes
SELECT descricaoProduto, nomeFabricante FROM tbl_produto
	INNER JOIN tbl_fabricante ON tbl_produto.codFabricante = tbl_fabricante.codFabricante

--b) Listar as descrições dos produtos ao lado do nome dos fornecedores;
SELECT descricaoProduto, nomeFornecedor FROM tbl_produto
	INNER JOIN tbl_fornecedor ON tbl_produto.codFornecedor = tbl_fornecedor.codFornecedor

--c) Listar a soma das quantidades dos produtos agrupadas pelo nome do fabricante
SELECT nomeFabricante, SUM(quantidadeProduto) 'produtosAgrupados' FROM tbl_fabricante
	INNER JOIN tbl_produto ON tbl_produto.codFabricante = tbl_fabricante.codFabricante
		GROUP BY nomeFabricante

--d) Listar o total das vendas ao lado do nome do cliente
SELECT nomeCliente, SUM(valorTotalVenda) 'totalGasto' FROM tbl_cliente
	INNER JOIN tbl_venda ON tbl_cliente.codCliente = tbl_venda.codCliente
		GROUP BY nomeCliente

--e) Listar a média dos preços dos produtos agrupados pelo nome do fornecedor
SELECT nomeFornecedor, AVG(valorProduto) 'média' FROM tbl_fornecedor
	INNER JOIN tbl_produto ON tbl_fornecedor.codFornecedor = tbl_produto.codFornecedor
		GROUP BY nomeFornecedor

--f) Listar todas a soma das vendas agrupadas pelo nome do cliente em ordem alfabética
SELECT nomeCliente, SUM(valorTotalVenda) 'totalGasto' FROM tbl_cliente
	INNER JOIN tbl_venda ON tbl_cliente.codCliente = tbl_venda.codCliente
		GROUP BY nomeCliente
			ORDER BY nomeCliente ASC

--g) Listar a soma dos preços dos produtos agrupados pelo nome do fabricante
SELECT nomeFabricante, SUM(valorProduto) FROM tbl_fabricante
	INNER JOIN tbl_produto ON tbl_fabricante.codFabricante = tbl_produto.codFabricante
		GROUP BY nomeFabricante

--h) Listar a média dos preços dos produtos agrupados pelo nome do fornecedor
SELECT nomeFornecedor, AVG(valorProduto) 'totalPrecoProduto' FROM tbl_fornecedor
	INNER JOIN tbl_produto ON tbl_fornecedor.codFornecedor = tbl_produto.codFornecedor
		GROUP BY nomeFornecedor

--i) Listar a soma das vendas agrupadas pelo nome do produto
SELECT descricaoProduto, SUM(quantidadeItensVenda) 'somaVendas' FROM tbl_produto
	INNER JOIN tbl_itensVenda ON tbl_produto.codProduto = tbl_itensVenda.codProduto
		GROUP BY descricaoProduto

--j) Listar a soma das vendas pelo nome do cliente somente das vendas realizadas em fevereiro de 2014
SELECT nomeCliente, SUM(valorTotalVenda) 'total', dataVenda FROM tbl_cliente
	INNER JOIN tbl_venda ON tbl_cliente.codCliente = tbl_venda.codCliente
		WHERE MONTH(dataVenda) = 2
			GROUP BY nomeCliente, dataVenda