USE bdEscolaDeIdiomas

--1. Criar uma stored procedure “Busca_Aluno” que receba o código do aluno e retorne seu nome e data de nascimento.
CREATE PROCEDURE BuscaAluno
	@nomeAlunoBusca VARCHAR (70)
	AS
	SELECT DISTINCT nomeAluno, dataNascAluno FROM tbAluno
	WHERE nomeAluno LIKE '%'+ @nomeAlunoBusca + '%'

EXEC BuscaAluno 'Igor'

--2. Criar uma stored procedure “Insere_Aluno” que insira um registro na tabela de Alunos.
CREATE PROCEDURE inserirAluno
	@nomeAluno VARCHAR(70),
	@rg VARCHAR (9),
	@cpf VARCHAR (11),
	@logradouro VARCHAR 

	AS
	INSERT INTO tbAluno(nomeAluno, 