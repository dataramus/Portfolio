/* ENABLING RESTRICTIONS */

USE COMMERCE_OLTP


ALTER TABLE SELLER ADD CONSTRAINT FK_MANAGER
FOREIGN KEY(ID_MANAGER) REFERENCES SELLER(IDSELLER)
GO

ALTER TABLE INVOICE ADD CONSTRAINT FK_INVOICE
FOREIGN KEY(ID_CUSTOMER) REFERENCES CUSTOMER(IDCUSTOMER)
GO

ALTER TABLE INVOICE ADD CONSTRAINT FK_INVOICE_SELLER
FOREIGN KEY(ID_SELLER) REFERENCES SELLER(IDSELLER)
GO

ALTER TABLE INVOICE_ITEM ADD CONSTRAINT FK_PRODUCT_ITEM
FOREIGN KEY(ID_PRODUCT) REFERENCES PRODUCT(IDPRODUCT)
GO

ALTER TABLE INVOICE_ITEM ADD CONSTRAINT FK_ITEM_INVOICE
FOREIGN KEY(ID_INVOICE) REFERENCES INVOICE(IDINVOICE)
GO

ALTER TABLE PRODUCT ADD CONSTRAINT FK_PRODUCT_SUPPLIER
FOREIGN KEY(ID_SUPPLIER) REFERENCES SUPPLIER(IDSUPPLIER)
GO

ALTER TABLE PRODUCT ADD CONSTRAINT FK_PRODUCT_CATEGORY
FOREIGN KEY(ID_CATEGORY) REFERENCES CATEGORY(IDCATEGORY)
GO

ALTER TABLE CUSTOMER_ADDRESS ADD CONSTRAINT FK_ADDRESS_CUSTOMER
FOREIGN KEY(ID_CUSTOMER) REFERENCES CUSTOMER(IDCUSTOMER)
GO

ALTER TABLE INVOICE ADD CONSTRAINT FK_PAYMENT_FORM
FOREIGN KEY(ID_PAYMENT) REFERENCES PAYMENT_FORM(IDPAYMENT)
GO