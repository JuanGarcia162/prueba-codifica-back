using Microsoft.AspNetCore.Mvc;
using SalesDP.Services.Services;

[ApiController]
[Route("api/[controller]")]
public class EmployeesController : ControllerBase
{
    private readonly ISalesService _salesService;

    public EmployeesController(ISalesService salesService)
    {
        _salesService = salesService;
    }

    [HttpGet]
    public async Task<IActionResult> GetEmployees()
    {
        var employees = await _salesService.GetEmployeesAsync();
        return Ok(employees);
    }
}
