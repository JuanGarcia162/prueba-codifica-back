using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using SalesDP.Data.Data;
using SalesDP.ProvisionalData.DTOs;

namespace SalesDP.Services.Services
{
    public class SalesService : ISalesService
    {
        private readonly StoreSampleContext _context;

        public SalesService(StoreSampleContext context)
        {
            _context = context;
        }
        public async Task<List<CustomerDto>> GetSalesDatePredictionAsync()
        {
            var customers = await _context.Customers
                .FromSqlRaw("EXEC Sales.SalesPrediction")
                .ToListAsync();

            return customers.Select(c => new CustomerDto
            {
                custid = c.CustomerID,
                CompanyName = c.CustomerName,
                LastOrderDate = c.LastOrderDate,
                NextPredictedOrder = c.NextPredictedOrder
            }).ToList();
        }

        public async Task<List<OrderDto>> GetOrdersBycustidAsync(int custid)
        {
            var orders = await _context.Orders
                .FromSqlRaw("EXEC Sales.GetOrdersByCustomer @custid", new SqlParameter("@custid", custid))
                .ToListAsync();

            return orders.Select(o => new OrderDto
            {
                OrderID = o.OrderID,
                RequiredDate = o.RequiredDate,
                ShippedDate = o.ShippedDate,
                ShipName = o.ShipName,
                ShipAddress = o.ShipAddress,
                ShipCity = o.ShipCity,
                Freight = o.Freight,
                ShipCountry = o.ShipCountry
            }).ToList();
        }


        public async Task<List<EmployeeDto>> GetEmployeesAsync()
        {
            var employees = await _context.Employees
                .FromSqlRaw("EXEC Sales.ListEmployees")
                .ToListAsync();

            return employees.Select(e => new EmployeeDto
            {
                EmpID = e.EmpID,
                FullName = e.FullName
            }).ToList();
        }

        public async Task<List<ShipperDto>> GetShippersAsync()
        {
            var shippers = await _context.Shippers
                .FromSqlRaw("EXEC Sales.ListShippers")
                .ToListAsync();

            return shippers.Select(s => new ShipperDto
            {
                ShipperID = s.ShipperID,
                CompanyName = s.CompanyName
            }).ToList();
        }

        public async Task<List<ProductDto>> GetProductsAsync()
        {
            var products = await _context.Products
                .FromSqlRaw("EXEC Sales.ListProducts")
                .ToListAsync();

            return products.Select(p => new ProductDto
            {
                ProductID = p.ProductID,
                ProductName = p.ProductName
            }).ToList();
        }

        public async Task CreateOrderAsync(OrderCreateDto orderCreateDto)
        {
            var discount = Math.Max(0, Math.Min(1, orderCreateDto.Discount));

            var parameters = new[]
            {
                new SqlParameter("@Empid", orderCreateDto.EmpID),
                new SqlParameter("@Shipperid", orderCreateDto.ShipperID),
                new SqlParameter("@Shipname", orderCreateDto.ShipName),
                new SqlParameter("@Shipaddress", orderCreateDto.ShipAddress),
                new SqlParameter("@Shipcity", orderCreateDto.ShipCity),
                new SqlParameter("@Orderdate", orderCreateDto.OrderDate),
                new SqlParameter("@Requireddate", orderCreateDto.RequiredDate),
                new SqlParameter("@Shippeddate", (object)orderCreateDto.ShippedDate ?? DBNull.Value),
                new SqlParameter("@Freight", orderCreateDto.Freight),
                new SqlParameter("@Shipcountry", orderCreateDto.ShipCountry),
                new SqlParameter("@Unitprice", orderCreateDto.UnitPrice),
                new SqlParameter("@Qty", orderCreateDto.Qty),
                new SqlParameter("@Discount", discount),
                new SqlParameter("@ProductID", orderCreateDto.ProductID),
                new SqlParameter("@CustomerID", orderCreateDto.CustomerID),
            };

            await _context.Database.ExecuteSqlRawAsync("EXEC Sales.InsertNewOrder @Empid, @Shipperid, @Shipname, @Shipaddress, @Shipcity, @Orderdate, @Requireddate, @Shippeddate, @Freight, @Shipcountry, @Unitprice, @Qty, @Discount, @ProductID, @CustomerID", parameters);
        }


    }
}
