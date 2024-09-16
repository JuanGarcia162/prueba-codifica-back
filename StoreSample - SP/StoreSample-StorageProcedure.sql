USE [StoreSample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- StorageProcedure [Sales].[GetOrdersByCustomer]
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

-- StorageProcedure [Sales].[InsertNewOrder]
CREATE PROCEDURE [Sales].[InsertNewOrder]
    @Empid INT,
    @Shipperid INT,
    @Shipname NVARCHAR(100),
    @Shipaddress NVARCHAR(200),
    @Shipcity NVARCHAR(100),
    @Orderdate DATE,
    @Requireddate DATE,
    @Shippeddate DATE = NULL,
    @Freight DECIMAL(10, 2),
    @Shipcountry NVARCHAR(100),
    @Unitprice DECIMAL(10, 2),
    @Qty INT,
    @Discount DECIMAL(5, 2),
    @ProductID INT,
    @CustomerID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        INSERT INTO Orders (Empid,Custid, Shipperid, Shipname, Shipaddress, Shipcity, Orderdate, Requireddate, Shippeddate, Freight, Shipcountry)
        VALUES (@Empid, @CustomerID, @Shipperid, @Shipname, @Shipaddress, @Shipcity, @Orderdate, @Requireddate, @Shippeddate, @Freight, @Shipcountry);

        DECLARE @NewOrderid INT;
        SET @NewOrderid = SCOPE_IDENTITY();

        INSERT INTO OrderDetails (Orderid, ProductID, Unitprice, Qty, Discount)
        VALUES (@NewOrderid, @ProductID, @Unitprice, @Qty, @Discount);

        COMMIT TRANSACTION;
        PRINT 'Order and details inserted successfully';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- StorageProcedure [Sales].[ListEmployees]
CREATE PROCEDURE [Sales].[ListEmployees]
AS
BEGIN
    SELECT Empid, CONCAT(Firstname, ' ', Lastname) AS FullName
    FROM HR.Employees;
END;
GO

-- StorageProcedure [Sales].[ListProducts]
CREATE PROCEDURE [Sales].[ListProducts]
AS
BEGIN
    SELECT productid, Productname
    FROM Production.Products;
END;
GO

-- StorageProcedure [Sales].[ListShippers]
CREATE PROCEDURE [Sales].[ListShippers]
AS
BEGIN
    SELECT shipperid, Companyname
    FROM Sales.Shippers;
END;
GO

-- StorageProcedure [Sales].[SalesPrediction]
CREATE PROCEDURE [Sales].[SalesPrediction]
AS
BEGIN
    WITH OrderIntervals AS (
        SELECT
            o1.custid AS CustomerID,
            DATEDIFF(day, o2.OrderDate, o1.OrderDate) AS IntervalDays
        FROM
            Sales.Orders o1
        JOIN
            Sales.Orders o2
        ON
            o1.custid = o2.custid
            AND o1.OrderDate > o2.OrderDate
    ),
    
    AverageIntervals AS (
        SELECT
            CustomerID,
            AVG(IntervalDays) AS AverageIntervalDays
        FROM
            OrderIntervals
        GROUP BY
            CustomerID
    )

    SELECT
        c.custid AS CustomerID,
        c.companyname AS CustomerName,
        lo.LastOrderDate,
        DATEADD(day, ai.AverageIntervalDays, lo.LastOrderDate) AS NextPredictedOrder
    FROM
        Sales.Customers c
    JOIN
        (SELECT custid AS CustomerID, MAX(OrderDate) AS LastOrderDate FROM Sales.Orders GROUP BY custid) lo
    ON
        c.custid = lo.CustomerID
    JOIN
        AverageIntervals ai
    ON
        c.custid = ai.CustomerID;
END;
GO