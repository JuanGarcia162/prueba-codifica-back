USE [StoreSample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Sales].[GetOrdersByCustomer]
    @custid INT
AS
BEGIN
    IF @custid IS NOT NULL
    BEGIN
        SELECT OrderID AS OrderID, 
               RequiredDate AS RequiredDate, 
               ShippedDate AS ShippedDate, 
               ShipName AS ShipName, 
               ShipAddress AS ShipAddress, 
               ShipCity AS ShipCity, 
               Freight AS Freight, 
               ShipCountry AS ShipCountry
        FROM Sales.Orders
        WHERE custid = @custid;
    END
    ELSE
    BEGIN
        PRINT 'ID de cliente no proporcionado';
    END
END;
GO