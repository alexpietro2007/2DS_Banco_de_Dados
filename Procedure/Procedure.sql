USE bdEscolaDeIdiomas

--1. Criar uma stored procedure “Busca_Aluno” que receba o código do aluno e retorne seu nome e data de nascimento.
CREATE PROCEDURE Busca_Aluno
	@nomeAlunoBusca VARCHAR (70)
	AS
	SELECT DISTINCT nomeAluno, dataNascAluno FROM tbAluno
	WHERE LOWER(nomeAluno) LIKE '%'+ LOWER(@nomeAlunoBusca) + '%'

EXEC Busca_Aluno'alex'

--2. Criar uma stored procedure “Insere_Aluno” que insira um registro na tabela de Alunos.
CREATE PROCEDURE Inserir_Aluno
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
				WHERE LOWER(nomeALuno) LIKE '%' + LOWER(@nomeAluno) + '%' AND cpfAluno = @cpf)
	begin
		PRINT 'aluno já cadastrado'
	end
	else
	begin
		INSERT INTO tbAluno(nomeAluno, rgAluno, cpfAluno, logradouro, numero, complemento, cep, bairro, cidade, dataNascAluno)VALUES
		(@nomeAluno, @rg, @cpf, @Logradouro, @numero, @complemento, @cep, @bairro, @cidade, @nasc)
		PRINT 'Aluno Inserido Com êxito'
	end

EXEC Inserir_Aluno'thais', '123456789', '12345678900', 'Rua 1', '32', 'casa', '08471290', 'ct', 'são paulo', '30/08/2007'

--3. Criar uma stored procedure “Aumenta_Preco” que, dados o nome do curso e um percentual, aumente o valor do curso com a porcentagem informada
CREATE PROCEDURE Aumenta_Preco 
	@preco FLOAT,
	@nomeCurso VARCHAR (50)
	AS
	BEGIN
		DECLARE @codCurso INT
		SET @codCurso =	(SELECT codCurso FROM tbCurso 
							WHERE LOWER(nomeCurso) = LOWER(@nomeCurso))
		IF exists (SELECT DISTINCT codCurso FROM tbCurso
					WHERE codCurso = @codCurso)
		BEGIN
			UPDATE tbCurso SET valorCurso =  valorCurso + (valorCurso * (@preco / 100))
			WHERE codCurso = @codCurso
			PRINT 'Valor Alterado com Sucesso'
		END
		ELSE
		BEGIN
			PRINT 'Curso não encontrado'
		END
	END

EXEC Aumenta_Preco 100, 'Inglês'
SELECT * FROM tbCurso

--4. Criar uma stored procedure “Exibe_Turma” que, dado o nome da turma exiba todas as informações dela.CREATE PROCEDURE Exibe_Turma	@nomeTurma VARCHAR (50)	AS	IF exists (SELECT descTurma FROM tbTurma
				WHERE descTurma LIKE  '%' + @nomeTurma + '%')
	BEGIN
		SELECT * FROM tbTurma 
		WHERE LOWER(descTurma) LIKE  '%' + LOWER(@nomeTurma) + '%'
	END
	ELSE
	BEGIN
		PRINT 'Turma Não encontrada'
	END

EXEC Exibe_Turma'Inglês 1A'

--5. Criar uma stored procedure “Exibe_AlunosdaTurma” que, dado o nome da turma exiba os seus alunos.
CREATE PROCEDURE Exibe_AlunosTurma 
	@nomeTurma VARCHAR (50)
	AS
	IF exists (SELECT descTurma FROM tbTurma
				WHERE LOWER(descTurma) LIKE  '%' + LOWER(@nomeTurma) + '%')
	BEGIN
		SELECT nomeAluno, descTurma FROM tbALuno
			INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codALuno
				INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
					WHERE descTurma LIKE '%' + @nomeTurma + '%'
	END
	ELSE
	BEGIN 
		PRINT 'Turma não encontrada'
	END

EXEC Exibe_AlunosTurma 'inglês'

--6- Criar uma stored procedure para inserir alunos, verificando pelo cpf se o aluno existe ou não, e informar essa condição via mensagemCREATE PROCEDURE Colocar_Aluno	@nomeAluno VARCHAR(70),
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
		IF exists (SELECT cpfALuno FROM tbAluno
					WHERE cpfAluno = @cpf)
		BEGIN
			PRINT 'Já Existe um Aluno Cadastrado com esse cpf'
		END
		ELSE
		BEGIN
			INSERT INTO tbAluno(nomeAluno, rgAluno, cpfAluno, logradouro, numero, complemento, cep, bairro, cidade, dataNascAluno)VALUES
			(@nomeAluno, @rg, @cpf, @Logradouro, @numero, @complemento, @cep, @bairro, @cidade, @nasc)
			PRINT 'Aluno Inserido Com êxito'
		END

EXEC Colocar_Aluno 'alex','093418048','12345234120','rua','12', 'casa', '008241233', 'ct', 'são paulo', '22/07/2001'

--7 Criar uma stored procedure que receba o nome do curso e o nome do aluno e matricule o mesmo no curso pretendido
CREATE PROCEDURE Matricular_Aluno
	@nomeAluno VARCHAR (70),
	@nomeCurso VARCHAR (50),
	@periodo VARCHAR (50)
	AS
	DECLARE @codAluno INT
	DECLARE @codCurso INT
	DECLARE @codTurma INT
	DECLARE @codPeriodo INT
	SET @codCurso = (SELECT DISTINCT codCurso FROM tbCurso
					WHERE LOWER(nomeCurso) = LOWER(@nomeCurso))
	SET @codAluno = (SELECT codAluno FROM tbAluno
					WHERE LOWER(nomeAluno) = @nomeAluno)
	SET @codPeriodo = (SELECT codPeriodo FROM tbPeriodo
						WHERE LOWER(descPeriodo) = LOWER(@periodo))
	SET @codTurma = (SELECT DISTINCT codTurma FROM tbTurma
					WHERE codCurso = @codCurso AND codPeriodo = @codPeriodo)
	IF exists (SELECT codAluno FROM tbAluno
				WHERE codAluno = @codAluno)
	BEGIN
		INSERT INTO tbMatricula(dataMatricula, codAluno, codTurma)VALUES
			(CAST(GETDATE() AS date), @codAluno, @codTurma)
	END
	ELSE
	BEGIN
		PRINT 'Aluno Não Encontrado'
	END

EXEC Matricular_Aluno 'alex', 'inglês', 'manhã'

SELECT * FROM tbMatricula