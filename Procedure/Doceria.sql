USE dbDoceria

--a) Criar uma Stored Procedure para inserir as categorias de produto conforme abaixo:
CREATE PROCEDURE Inserir_Cartegoria
	@nomeCartegoria VARCHAR(70)
	AS
		IF EXISTS (SELECT nomeCartegoriaProduto FROM tbl_Cartegoria
					WHERE LOWER(nomeCartegoriaProduto) = @nomeCartegoria)
		BEGIN 
			PRINT 'O nome já existe'
		END
		ELSE
		BEGIN
			INSERT INTO tbl_Cartegoria(nomeCartegoriaProduto)VALUES
			(@nomeCartegoria)
		END
	GO

EXEC Inserir_Cartegoria 'Bolo Festa'
EXEC Inserir_Cartegoria 'Bolo Simples'
EXEC Inserir_Cartegoria 'Bolo Torta'
EXEC Inserir_Cartegoria 'Bolo Salgado'

--b) Criar uma Stored Procedure para inserir os produtos abaixo, sendo que, a procedure deveráantes de inserir verificar se o nome do produto já existe, evitando assim que um produto seja duplicado:
CREATE PROCEDURE Inserir_Produto
	@nomeProduto VARCHAR(70),
	@precoKilo MONEY,
	@codCartegoria INT
	AS
		IF EXISTS (SELECT nomeProduto FROM tbl_Produto
					WHERE LOWER(nomeProduto) = LOWER(@nomeProduto))
		BEGIN
			PRINT 'Produto já Cadastrado'
		END
		ELSE BEGIN IF EXISTS (SELECT codCartegoriaProduto FROM tbl_Cartegoria
						WHERE codCartegoriaProduto = @codCartegoria)
			 BEGIN
				INSERT INTO tbl_Produto(nomeProduto, precoKiloProduto, codCartegoriaProduto)VALUES
				(@nomeProduto, @precoKilo, @codCartegoria)
			 END
			 ELSE
			 BEGIN
				PRINT 'A Cartegoria inserida não existe'
			 END
		END
	GO

EXEC Inserir_Produto 'Bolo Floresta Negra', '42', 1
EXEC Inserir_Produto 'Bolo Prestígio', '43', 1
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

--c) Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que deverão ser feitas duas validações: - Verificar pelo CPF se o cliente já existe. Caso já exista emitir a mensagem: “Cliente cpf XXXXX já cadastrado” (Acrescentar a coluna CPF) - Verificar se o cliente é morador de Itaquera ou Guaianases, pois a confeitaria não realiza entregas para clientes que residam fora desses bairros. Caso o cliente não seja morador desses bairros enviar a mensagem “Não foi possível cadastrar o cliente XXXX pois o bairro XXXX não é atendido pela confeitaria”CREATE PROCEDURE Inserir_Cliente 		@nomeCliente VARCHAR(70),		@cpf CHAR(11),		@dataNasc DATE, 		@rua VARCHAR(70),		@numCasa INT,		@cep CHAR(8), 		@bairro VARCHAR(70),		@sexo CHAR(1),		@cidade VARCHAR(70),		@estado VARCHAR(2)	AS		DECLARE @cpfFormato VARCHAR(14)		SET @cpfFormato = STUFF(STUFF(STUFF(@cpf, 10, 0, '-'), 7, 0, '.'), 4, 0, '.');		IF EXISTS (SELECT cpfCliente FROM tbl_Cliente					WHERE cpfCliente = @cpf)		BEGIN			PRINT 'Cliente cpf:'+ @cpfFormato +' já cadastrado'		END		ELSE BEGIN IF LOWER(@bairro) IN ('itaquera', 'guaianases')					BEGIN						INSERT INTO tbl_Cliente(nomeCliente, bairroCliente, cepCliente, cidadeCliente, dataNascCliente, cpfCliente, estadoCliente, numCasaCliente, sexoCliente, ruaCLiente)VALUES						(@nomeCliente, @bairro, @cep, @cidade, @dataNasc, @cpf, @estado, @numCasa, @sexo, @rua)					END ELSE					BEGIN						PRINT 'Não foi possível cadastrar o cliente '+ @nomeCliente +' pois o bairro '+ @bairro +' não é atendido pela confeitaria'					END		END	GOEXEC Inserir_Cliente 'Samira Fatah', '12345678911','1990/05/05', 'Rua Aguapei', '1000', '08090000', 'Guaianases', 'F' , 'São Paulo', 'SP' EXEC Inserir_Cliente 'Celia Nogueira', '12345672911','1992/06/06', 'Rua Andes', '234', '08456090', 'Guaianases', 'F' , 'São Paulo', 'SP' EXEC Inserir_Cliente 'Paulo Cesar Siqueira', '12346678911','1984/04/04', 'Rua Castelo do Piauí', '232', '08190000', 'Itaquera', 'M' , 'São Paulo', 'SP' EXEC Inserir_Cliente 'Rodrigo Favaroni', '12345678811','1991/04/09', 'Rua Sansão Castelo Branco', '10', '08431090', 'Guaianases', 'F' , 'São Paulo', 'SP' EXEC Inserir_Cliente 'Flávia Regina Brito', '12145678911','1992/04/22', 'Rua Mariano Moro', '300', '08200123', 'Itaquera', 'F' , 'São Paulo', 'SP' --d) Criar via stored procedure as encomendas abaixo relacionadas, fazendo as verificações abaixo: - No momento da encomenda o cliente irá fornecer o seu cpf. Caso ele não tenha sido cadastrado enviar a mensagem “não foi possível efetivar a encomenda pois o cliente xxxx não está cadastrado” - Verificar se a data de entrega não é menor do que a data da encomenda. Caso seja enviar a mensagem “não é possível entregar uma encomenda antes da encomenda ser realizada” - Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: “Encomenda XXX para o cliente YYY efetuada com sucesso” sendo que no lugar de XXX deverá aparecer o número da encomenda e no YYY deverá aparecer o nome do clienteCREATE PROCEDURE Criar_Encomenda		@dataEncomenda DATE,			@cpfCliente CHAR(11),		@valor MONEY,		@dataEntrega DATE	AS		DECLARE @codCliente INT		DECLARE @cpfF VARCHAR(14)		DECLARE @nome VARCHAR(70)		IF EXISTS (SELECT cpfCliente FROM tbl_Cliente					WHERE cpfCliente = @cpfCliente)		BEGIN			IF @dataEntrega < @dataEncomenda			BEGIN				PRINT 'não é possível entregar uma encomenda antes da encomenda ser realizada'			END			ELSE BEGIN				DECLARE @codEncomenda INT				SET @codEncomenda = SCOPE_IDENTITY();				SET @codCliente = (SELECT codCliente FROM tbl_Cliente									WHERE cpfCliente = @cpfCliente)				SET @nome = (SELECT nomeCliente FROM tbl_Cliente								WHERE codCliente = @codCliente)				INSERT INTO tbl_Encomenda(dataEncomenda, codCliente, valorTotalEncomenda, dataEntregaEncomenda)VALUES				(@dataEncomenda, @codCliente, @valor, @dataEntrega)				RETURN PRINT 'Encomenda '+ CAST(@codEncomenda AS VARCHAR) +' para o cliente' + @nome + ' efetuada com sucesso'			END		END 		ELSE BEGIN			SET @cpfF = STUFF(STUFF(STUFF(@cpfCliente, 10, 0, '-'), 7, 0, '.'), 4, 0, '.');			PRINT 'não foi possível efetivar a encomenda pois o cliente do Cpf: '+ @cpfF +'  não está cadastrado'		END	GOEXEC Criar_Encomenda '08/08/2015', '12345678911', 450 , '15/08/2015' EXEC Criar_Encomenda '10/10/2015', '12345672911', 200 , '15/10/2015' EXEC Criar_Encomenda '10/10/2015', '12346678911', 150 , '10/12/2015' EXEC Criar_Encomenda '06/10/2015', '12345678911', 250 , '12/10/2015' EXEC Criar_Encomenda '05/10/2015', '12345678811', 150 , '12/10/2015' 