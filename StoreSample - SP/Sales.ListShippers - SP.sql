USE [StoreSample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Sales].[ListShippers]
AS
BEGIN
    SELECT shipperid, Companyname
    FROM Sales.Shippers;
END;
GO