USE dbDoceria

--a) Criar uma Stored Procedure para inserir as categorias de produto conforme abaixo:
CREATE PROCEDURE Inserir_Cartegoria
	@nomeCartegoria VARCHAR(70)
	AS
		IF EXISTS (SELECT nomeCartegoriaProduto FROM tbl_Cartegoria
					WHERE LOWER(nomeCartegoriaProduto) = @nomeCartegoria)
		BEGIN 
			PRINT 'O nome j� existe'
		END
		ELSE
		BEGIN
			INSERT INTO tbl_Cartegoria(nomeCartegoriaProduto)VALUES
			(@nomeCartegoria)
		END

EXEC Inserir_Cartegoria 'Bolo Festa'
EXEC Inserir_Cartegoria 'Bolo Simples'
EXEC Inserir_Cartegoria 'Bolo Torta'
EXEC Inserir_Cartegoria 'Bolo Salgado'

--b) Criar uma Stored Procedure para inserir os produtos abaixo, sendo que, a procedure dever�antes de inserir verificar se o nome do produto j� existe, evitando assim que um produto seja duplicado:
CREATE PROCEDURE Inserir_Produto
	@nomeProduto VARCHAR(70),
	@precoKilo MONEY,
	@codCartegoria INT
	AS
		IF EXISTS (SELECT nomeProduto FROM tbl_Produto
					WHERE LOWER(nomeProduto) = LOWER(@nomeProduto))
		BEGIN
			PRINT 'Produto j� Cadastrado'
		END
		ELSE BEGIN IF EXISTS (SELECT codCartegoriaProduto FROM tbl_Cartegoria
						WHERE codCartegoriaProduto = @codCartegoria)
			 BEGIN
				INSERT INTO tbl_Produto(nomeProduto, precoKiloProduto, codCartegoriaProduto)VALUES
				(@nomeProduto, @precoKilo, @codCartegoria)
			 END
			 ELSE
			 BEGIN
				PRINT 'A Cartegoria inserida n�o existe'
			 END
		END

EXEC Inserir_Produto 'Bolo Floresta Negra', '42', 1
EXEC Inserir_Produto 'Bolo Prest�gio', '43', 1
EXEC Inserir_Produto 'Bolo Nutella', '44', 1
EXEC Inserir_Produto 'Bolo Formigueiro', '17', 2
EXEC Inserir_Produto 'Bolo de Cenoura', '19', 2		
EXEC Inserir_Produto 'Torta de Palmito', '45', 3
EXEC Inserir_Produto 'Torta de Frango com Catupiry', '47', 3
EXEC Inserir_Produto 'Torta de Escarola', '44', 3
EXEC Inserir_Produto 'Coxinha de Frango', '25', 4
EXEC Inserir_Produto 'Esfiha carne', '27', 4
EXEC Inserir_Produto 'Folhado queijo', '31', 4
EXEC Inserir_Produto 'Risoles misto', '29', 4

--c) Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que dever�o ser feitas duas valida��es: - Verificar pelo CPF se o cliente j� existe. Caso j� exista emitir a mensagem: �Cliente cpf XXXXX j� cadastrado� (Acrescentar a coluna CPF) - Verificar se o cliente � morador de Itaquera ou Guaianases, pois a confeitaria n�o realiza entregas para clientes que residam fora desses bairros. Caso o cliente n�o seja morador desses bairros enviar a mensagem �N�o foi poss�vel cadastrar o cliente XXXX pois o bairro XXXX n�o � atendido pela confeitaria�CREATE PROCEDURE Inserir_Cliente 	@nomeCliente VARCHAR(70),	@cpf CHAR(11),	@dataNasc DATE, 	@rua VARCHAR(70),	@numCasa INT,	@cep CHAR(8), 	@bairro VARCHAR(70),	@sexo CHAR(2),	@cidade VARCHAR(70),	@estado VARCHAR(2)	AS		IF EXISTS (SELECT cpfCliente FROM tbl_Cliente					WHERE cpfCliente = @cpf)		BEGIN		DECLARE @cpfFormatado VARCHAR(14);
		SET @cpfFormatado = STUFF(STUFF(STUFF(@cpf, 10, 0, '-'), 7, 0, '.'), 4, 0, '.');
			PRINT 'Cliente cpf:'+ @cpfFormato +'j� cadastrado'		END		ELSE 		BEGIN					END