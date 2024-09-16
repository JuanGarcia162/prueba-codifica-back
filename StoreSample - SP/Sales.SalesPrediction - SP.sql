USE [StoreSample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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