
--1. Crie uma visão “Preço_Baixo” que exiba o código, nome do curso, carga horária e o valor do curso de todos os cursos que tenha preço inferior ao preço médio.
CREATE VIEW vwPreco_Baixo AS
	SELECT nomeCurso AS 'nome', cargaHorariaCurso AS 'cargaHoraria', valorCurso AS 'valor' FROM tbl_curso
	WHERE valorCurso < (SELECT AVG(tbl_curso.valorCurso) FROM tbl_curso)
	
--2. Usando a visão “Preço_Baixo”, mostre todos os cursos ordenados por carga horária.
  SELECT*FROM vwPreco_Baixo 
	ORDER BY cargaHoraria

--3. Crie uma visão “Alunos_Turma” que exiba o curso e a quantidade de alunos por turma.
CREATE VIEW vwAlunos_Turma AS
	SELECT nomeCurso AS nome, COUNT(tbl_aluno.codAluno) AS Quant_alunos FROM tbl_curso
		INNER JOIN tbl_turma ON tbl_curso.codCurso = tbl_turma.codCurso
			INNER JOIN tbl_matricula ON tbl_turma.codTurma = tbl_matricula.codTurma
				INNER JOIN tbl_aluno ON tbl_matricula.codAluno = tbl_aluno.codAluno
					GROUP BY nomeCurso

--4. Usando a visão “Alunos_Turma” exiba a turma com maior número de alunos.SELECT nome, Quant_alunos FROM vwAlunos_Turma	WHERE Quant_alunos = (SELECT MAX(Quant_alunos) FROM vwAlunos_Turma)--5. crie uma visão “Turma_Curso que exiba o curso e a quantidade de turmas.CREATE VIEW vwTurma_Curso AS	SELECT nomeCurso AS nome, COUNT(tbl_turma.codTurma) AS Quant_Turma FROM tbl_curso		INNER JOIN tbl_turma ON tbl_curso.codCurso = tbl_turma.codCurso			GROUP BY nomeCurso--6. Usando a visão “Turma_Curso exiba o curso com menor número de turmas.SELECT nome, Quant_turma FROM vwTurma_Curso	WHERE Quant_Turma = (SELECT MIN(Quant_Turma) FROM vwTurma_Curso)	