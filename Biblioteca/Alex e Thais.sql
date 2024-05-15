USE bdLivrariaBrasileira

--a) A quantidade de livros agrupado pelo nome do gênero
SELECT nomeGenero, COUNT(codLivro) FROM tbGenero
	INNER JOIN tbLivro ON tbGenero.codGenero = tbLivro.codGenero 
		GROUP BY nomeGenero

--b) A soma das páginas agrupada pelo nome do autor
SELECT nomeAutor, SUM(numPaginas)'Numero de Pagina' FROm tbAutor
	INNER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor
		GROUP BY nomeAutor

--c) A média de páginas agrupada pelo nome do autor em ordem alfabética (de A a Z)SELECT nomeAutor, AVG(numPaginas)'Numero de Pagina' FROm tbAutor
	INNER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor
		GROUP BY nomeAutor
			ORDER BY nomeAutor ASC

--d) A quantidade de livros agrupada pelo nome da editora em ordem alfabética inversa (de Z a A)
SELECT nomeEditora, COUNT(codLivro)'Quantidade de Livros' FROM tbEditora
	INNER JOIN tbLivro ON tbEditora.codEditora = tbLivro.codEditora
		GROUP BY nomeEditora
			ORDER BY nomeEditora DESC

--e) A soma de páginas dos livros agrupados pelo nome do autor que sejam de autores cujo nome comece com a letra “C”
SELECT nomeAutor, SUM(numPaginas)'Numero de Pagina' FROm tbAutor
	INNER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor
		WHERE nomeAutor LIKE 'c%'
			GROUP BY nomeAutor

--f) A quantidade de livros agrupados pelo nome do autor, cujo nome do autor seja “Machado de Assis” ou “Cora Coralina” ou “Graciliano Ramos” ou “Clarice Lispector”
SELECT nomeAutor, COUNT(codLivro)'Quantidade de Livros' FROm tbAutor
	INNER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor
	WHERE nomeAutor IN ('Machado de Assis', 'Cora Coralina', 'Graciliano Ramos', 'Clarice Lispector')
		GROUP BY nomeAutor

--g) A soma das páginas dos livros agrupadas pelo nome da editora cujo número de páginas esteja entre 200 e 500 (inclusive)SELECT nomeEditora, SUM(numPaginas)'Quantidade de paginas' FROM tbEditora
	INNER JOIN tbLivro ON tbEditora.codEditora = tbLivro.codEditora
		WHERE numPaginas <= 500 AND numPaginas >= 200	
			GROUP BY nomeEditora

-- h) O nome dos livros ao lado do nome das editoras e do nome dos autores
SELECT	nomeLivro, nomeAutor, nomeEditora FROM tbLivro
	FULL JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		FULL JOIN tbEditora ON tbLivro.codEditora = tbEditora.codEditora
 
 -- i) O nome dos livros ao lado do nome do autor somente daqueles cujo nome da editora for “Cia das Letras”
SELECT nomeLivro, nomeAutor FROM tbLivro
	INNER JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		INNER JOIN tbEditora ON tbLivro.codEditora = tbEditora.codEditora
			WHERE nomeEditora LIKE 'Companhia das Letras'

--j) O nome dos livros ao lado dos nomes dos autores, somente dos livros que não forem do autor “Érico Veríssimo”
SELECT nomeLivro, nomeAutor FROM tbLivro
	INNER JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		WHERE nomeAutor NOT LIKE 'Érico Veríssimo'

--k) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que não tem livros cadastradosSELECT nomeAutor, nomeLivro FROM tbAutor	LEFT JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor--l) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que não tem autores cadastradosSELECT nomeAutor, nomeLivro FROM tbAutor	RIGHT JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor--m) O nome dos autores ao lado dos nomes dos livros, indiferente do autor ter ou não livro publicado, e indiferente do livro pertencer a algum autorSELECT nomeAutor, nomeLivro FROM tbAutor	FULL JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor--n) A editora Ática irá publicar todos os títulos dessa livraria. Criar um select que associe os nomes de todos os livros ao lado do nome da editora Ática.SELECT nomeEditora, nomeLivro FROM tbEditora	INNER JOIN tbLivro ON tbEditora.codEditora = tbLivro.codEditora		WHERE nomeEditora LIKE 'Ática'--o) Somente os nomes dos autores que não tem livros cadastradosSELECT nomeAutor FROM tbAutor	LEFT JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor		WHERE tbLivro.codAutor IS NULL--p) Os nomes dos gêneros que não possuem nenhum livro cadastradoSELECT nomeGenero FROM tbGenero	LEFT JOIN tbLivro ON tbGenero.codGenero = tbLivro.codGenero		WHERE tbLivro.codGenero IS NULL