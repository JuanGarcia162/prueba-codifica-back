using Microsoft.AspNetCore.Mvc;
using SalesDP.ProvisionalData.DTOs;
using SalesDP.Services.Services;

[ApiController]
[Route("api/[controller]")]
public class CustomersController : ControllerBase
{
    private readonly ISalesService _salesService;

    public CustomersController(ISalesService salesService)
    {
        _salesService = salesService;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<CustomerDto>>> GetCustomers()
    {
        var customers = await _salesService.GetSalesDatePredictionAsync();
        return Ok(customers);
    }
}

