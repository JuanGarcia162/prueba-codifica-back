# Sales Data Prediction - Back
#### Tecnical test for Codifica

## Description

This is a project developed with Asp.NET Core. The project includes functionalities for managing and creating orders, using .NET 8.

## Technologies

- **.NET 8.0**: Framework 
- **ASP .NET CORE WEB API**: For the creation of service and API
- **Entity Framework Core**: ORM for data access and object mapping.
- **SQL Server**: Relational database used to store information
- **Stored Procedures**: Stored procedures in SQL Server for business logic in the database.
- **Swagger**: For API documentation and testing.

## Prerequisites

- [EntityFramework](https://learn.microsoft.com/es-es/ef/core/)
- [EntityFramework.SqlServer](https://learn.microsoft.com/es-es/ef/core/)
- [SqlClient](https://github.com/dotnet/SqlClient)
- [Front Angular](https://github.com/JuanGarcia162/prueba-codifica-Front) (A Frontend is required for the project to work.)

## Cloning the Repository

To clone this project, run the following command in your terminal:

```bash
git clone https://github.com/JuanGarcia162/prueba-codifica-back.git
```

# Running the Project

Navigate to the project directory:

```bash
dotnet run --project SalesDP.API
```

### Execute StorageProcedures on SQL SERVER
Find them in the StoreSample - SP folder.

```bash
StoreSample-StorageProcedure (All procedures)
```
#### OR

Execute Individual StorageProcedures on SQL SERVER

```bash
Sales.SalesPrediction - SP

Sales.ListShippers - SP

Sales.ListProducts - SP

Sales.ListEmployees - SP

Sales.InsertNewOrder - SP

Sales.GetOrdersByCustomer - SP
```

## EndPoints

- GET **/api/customers**
- GET **/api/orders**
- POST **/api/orders/id**
- GET **/api/employees**
- GET **/api/shippers**
- GET **/api/products**

