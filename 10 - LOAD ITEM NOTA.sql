/* ITEM NOTA */

USE COMERCIO_OLTP
GO

TRUNCATE TABLE ITEM_NOTA
GO

DECLARE
			@ID_PRODUTO INT,
			@ID_NOTA_FISCAL INT,
			@QUANTIDADE INT,
			@VALOR NUMERIC(10,2),
			@TOTAL NUMERIC(10,2)
BEGIN

			SET @ID_PRODUTO = 
			(SELECT TOP 1 IDPRODUTO FROM PRODUTO ORDER BY NEWID())
			SET @ID_NOTA_FISCAL = 
			(SELECT TOP 1 IDNOTA FROM NOTA_FISCAL ORDER BY NEWID())
			SET @QUANTIDADE = (SELECT ROUND(RAND()* 3 + 1, 0))
			SET @VALOR = (SELECT VALOR FROM PRODUTO
			        	  WHERE IDPRODUTO = @ID_PRODUTO)
			SET @TOTAL = @QUANTIDADE * @VALOR

			INSERT INTO ITEM_NOTA(ID_PRODUTO,ID_NOTA_FISCAL,QUANTIDADE,TOTAL)
			 VALUES
			(@ID_PRODUTO,@ID_NOTA_FISCAL,@QUANTIDADE,@TOTAL)
END
GO 26000

SELECT TOP 1 * FROM NOTA_FISCAL
SELECT TOP 1 * FROM ITEM_NOTA
SELECT * FROM ITEM_NOTA

/* CHECKING THE BANKNOTES THAT WERE LEFT WITHOUT ITEMS */

SELECT IDNOTA FROM NOTA_FISCAL
WHERE IDNOTA NOT IN(SELECT ID_NOTA_FISCAL FROM
ITEM_NOTA)
GO

SELECT * FROM ITEM_NOTA
GO

/* CREATING A CURSOR TO FILL IN THE NOTES THAT HAD NO ITEMS */

CREATE PROCEDURE CAD_NOTAS AS

DECLARE C_NOTAS CURSOR FOR
	SELECT IDNOTA FROM NOTA_FISCAL
	WHERE IDNOTA NOT IN(SELECT ID_NOTA_FISCAL FROM
	ITEM_NOTA)	
	
DECLARE @IDNOTA INT,
		@ID_PRODUTO INT,
		@VALOR DECIMAL(10,2), 
		@TOTAL DECIMAL(10,2)	    
		
OPEN C_NOTAS

FETCH NEXT FROM C_NOTAS
INTO @IDNOTA

WHILE @@FETCH_STATUS = 0
BEGIN
	
			SET @ID_PRODUTO = 
			(SELECT TOP 1 IDPRODUTO FROM PRODUTO ORDER BY NEWID())
			SET @VALOR = (SELECT VALOR FROM PRODUTO
			        	  WHERE IDPRODUTO = @ID_PRODUTO)
			SET @TOTAL = @VALOR
	
			INSERT INTO ITEM_NOTA(ID_PRODUTO,ID_NOTA_FISCAL,QUANTIDADE,TOTAL)
			 VALUES(@ID_PRODUTO,@IDNOTA,1,@TOTAL)
		
	FETCH NEXT FROM C_NOTAS
	INTO @IDNOTA
	
END

CLOSE C_NOTAS
DEALLOCATE C_NOTAS
GO

EXEC CAD_NOTAS
GO

/* CREATING A VIEW FOR CHECKING THE ORDERED ITEMS */

CREATE VIEW V_ITEM_NOTA AS
SELECT ID_NOTA_FISCAL AS "NOTA FISCAL",
	   PRODUTO, 
	   VALOR, 
       QUANTIDADE,
	   TOTAL AS "TOTAL DO ITEM"
FROM PRODUTO
INNER JOIN ITEM_NOTA
ON IDPRODUTO = ID_PRODUTO
GO

SELECT * FROM ITEM_NOTA
SELECT * FROM V_ITEM_NOTA
ORDER BY 1
GO

SELECT * FROM NOTA_FISCAL

SELECT C.NOME, C.SOBRENOME,C.SEXO,N.DATA,N.IDNOTA,P.PRODUTO,
N.TOTAL
FROM CLIENTE C
INNER JOIN NOTA_FISCAL N
ON C.IDCLIENTE = N.ID_CLIENTE
INNER JOIN ITEM_NOTA I
ON N.IDNOTA = I.ID_NOTA_FISCAL
INNER JOIN PRODUTO P
ON P.IDPRODUTO = I.ID_PRODUTO
ORDER BY 5
GO
