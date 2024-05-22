USE db_estoque

--1. Criar uma consulta que retorne o código do produto, o nome do produto e o nome do fabricante somente daqueles produtos que custam igual ao valor mais alto;
SELECT codProduto, descricaoProduto, nomeFabricante FROM tbl_produto p
	INNER JOIN tbl_fabricante f ON p.codFabricante = f.codFabricante
		WHERE valorProduto = (SELECT MAX(valorProduto) FROM tbl_Produto)
		