USE [StoreSample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Sales].[ListProducts]
AS
BEGIN
    SELECT productid, Productname
    FROM Production.Products;
END;
GO