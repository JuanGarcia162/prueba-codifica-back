USE [StoreSample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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