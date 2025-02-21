CREATE DATABASE db_primeira_data_base --ddl
USE db_primeira_data_base --ddl
CREATE TABLE tbl_produtos(

codigo int NOT NULL,
produto varchar(20) NOT NULL,
data_compra date NOT NULL,
PRIMARY KEY(codigo)

)

INSERT INTO tbl_produtos (codigo,produto,data_compra) VALUES --dml
(1,'arroz',GETDATE()),--dml
(2,'açucar',GETDATE()) --dml


SELECT * FROM tbl_produtos --dql

