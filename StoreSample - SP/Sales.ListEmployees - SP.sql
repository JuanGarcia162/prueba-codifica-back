USE [StoreSample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Sales].[ListEmployees]
AS
BEGIN
    SELECT Empid, CONCAT(Firstname, ' ', Lastname) AS FullName
    FROM HR.Employees;
END;
GO