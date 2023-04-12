/* LOAD ADDRESS */

USE COMMERCE_OLTP
GO

SELECT COUNT(*) FROM CUSTOMER
GO

SELECT COUNT(*) FROM CUSTOMER_ADDRESS
GO

SELECT C.CUSTOMER_NAME, E.STREET
FROM CUSTOMER C
INNER JOIN CUSTOMER_ADDRESS E
ON C.IDCUSTOMER = E.ID_CUSTOMER
GO

SELECT COUNT(*) AS QUANTIDADE
FROM CUSTOMER C
INNER JOIN CUSTOMER_ADDRESS E
ON C.IDCUSTOMER = E.ID_CUSTOMER
GO

