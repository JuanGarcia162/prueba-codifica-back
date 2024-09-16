using SalesDP.ProvisionalData.DTOs;

namespace SalesDP.Services.Services
{
    public interface ISalesService
    {
        Task<List<CustomerDto>> GetSalesDatePredictionAsync();
        Task<List<OrderDto>> GetOrdersBycustidAsync(int custid);
        Task<List<EmployeeDto>> GetEmployeesAsync();
        Task<List<ShipperDto>> GetShippersAsync();
        Task<List<ProductDto>> GetProductsAsync();
        Task CreateOrderAsync(OrderCreateDto orderCreateDto);
    }
}
