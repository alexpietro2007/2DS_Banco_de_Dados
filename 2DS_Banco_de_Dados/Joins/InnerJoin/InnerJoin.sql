use db_estoque

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
