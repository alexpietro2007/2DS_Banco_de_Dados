USE bdEscolaDeIdiomas

--1. Criar uma stored procedure “Busca_Aluno” que receba o código do aluno e retorne seu nome e data de nascimento.
CREATE PROCEDURE BuscaAluno
	@nomeAlunoBusca VARCHAR (70)
	AS
	SELECT DISTINCT nomeAluno, dataNascAluno FROM tbAluno
	WHERE nomeAluno LIKE '%'+ @nomeAlunoBusca + '%'

EXEC BuscaAluno 'alex'

--2. Criar uma stored procedure “Insere_Aluno” que insira um registro na tabela de Alunos.
CREATE PROCEDURE inserirAluno
	@nomeAluno VARCHAR(70),
	@rg VARCHAR (9),
	@cpf VARCHAR (11),
	@logradouro VARCHAR (70),
	@numero INT,
	@complemento VARCHAR(50),
	@cep VARCHAR (9),
	@bairro VARCHAR (50),
	@cidade VARCHAR (50),
	@nasc smalldatetime

	AS
	IF exists (SELECT nomeAluno, cpfALuno FROM tbAluno
				WHERE nomeALuno LIKE '%' + @nomeAluno + '%' AND cpfAluno = @cpf)
	begin
		PRINT 'aluno já cadastrado'
	end
	else
	begin
		INSERT INTO tbAluno(nomeAluno, rgAluno, cpfAluno, logradouro, numero, complemento, cep, bairro, cidade, dataNascAluno)VALUES
		(@nomeAluno, @rg, @cpf, @Logradouro, @numero, @complemento, @cep, @bairro, @cidade, @nasc)
		PRINT 'Aluno Inserido Com êxito'
	end

	DROP PROCEDURE inserirAluno

EXEC inserirAluno 'thais', '123456789', '12345678900', 'Rua 1', '32', 'casa', '08471290', 'ct', 'são paulo', '30/08/2007'

--3. Criar uma stored procedure “Aumenta_Preco” que, dados o nome do curso e um percentual, aumente o valor do curso com a porcentagem informada
CREATE PROCEDURE aumentaPreco 
	@preco FLOAT,
	@nomeCurso VARCHAR (50)
	AS
	begin
		DECLARE @codCurso int
		SET @codCurso =	(SELECT codCurso FROM tbCurso WHERE nomeCurso LIKE @nomeCurso)
		IF exists (SELECT DISTINCT codCurso FROM tbCurso
					WHERE codCurso = @codCurso)
		begin
			UPDATE tbCurso SET valorCurso =  valorCurso + (valorCurso * (@preco / 100))
			PRINT 'Valor Alterado com Sucesso'
		end
		else
		begin
			PRINT 'Curso não encontrado'
		end
	end
		
EXEC aumentaPreco 100, 'Inglês'
