using Microsoft.AspNetCore.Mvc;
using SalesDP.Services.Services;

[ApiController]
[Route("api/[controller]")]
public class ShippersController : ControllerBase
{
    private readonly ISalesService _salesService;

    public ShippersController(ISalesService salesService)
    {
        _salesService = salesService;
    }

    [HttpGet]
    public async Task<IActionResult> GetShippers()
    {
        var shippers = await _salesService.GetShippersAsync();
        return Ok(shippers);
    }
}
