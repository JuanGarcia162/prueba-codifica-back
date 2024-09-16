using Microsoft.AspNetCore.Mvc;
using SalesDP.Services.Services;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly ISalesService _salesService;

    public ProductsController(ISalesService salesService)
    {
        _salesService = salesService;
    }

    [HttpGet]
    public async Task<IActionResult> GetProducts()
    {
        var products = await _salesService.GetProductsAsync();
        return Ok(products);
    }
}
