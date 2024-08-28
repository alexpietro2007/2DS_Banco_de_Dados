USE db_estoque

--1. Criar uma consulta que retorne o código do produto, o nome do produto e o nome do fabricante somente daqueles produtos que custam igual ao valor mais alto;
SELECT codProduto, descricaoProduto, nomeFabricante FROM tbl_produto p
	INNER JOIN tbl_fabricante f ON p.codFabricante = f.codFabricante
		WHERE valorProduto = (SELECT MAX(valorProduto) FROM tbl_Produto)

--2. Criar uma consulta que retorne o nome do produto e o nome do fabricante e o valor somente dos produtos que custem acima do valor médio dos produtos em estoque
SELECT descricaoProduto, nomeFabricante FROM tbl_produto
	INNER JOIN tbl_fabricante ON tbl_produto.codFabricante = tbl_fabricante.codFabricante
		WHERE valorProduto > (SELECT AVG(tbl_produto.valorProduto) FROM tbl_produto)

--3. Criar uma consulta que retorne o nome dos clientes que tiveram vendas com valor acima do valor médio das vendas
SELECT DISTINCT nomeCliente FROM tbl_cliente
	INNER JOIN tbl_venda ON tbl_cliente.codCliente = tbl_venda.codCliente
		WHERE valorTotalVenda > (SELECT AVG(tbl_venda.valorTotalVenda) FROM tbl_venda)

--4. Criar uma consulta que retorno o nome e o preço dos produtos mais carosSELECT descricaoProduto, valorProduto FROM tbl_produto 	WHERE valorProduto = (SELECT MAX(tbl_produto.valorProduto) FROM tbl_produto)--5. Criar uma consulta que retorne o nome e o preço do produto mais baratoSELECT descricaoProduto, valorProduto FROM tbl_produto 	WHERE valorProduto = (SELECT MIN(tbl_produto.valorProduto) FROM tbl_produto)