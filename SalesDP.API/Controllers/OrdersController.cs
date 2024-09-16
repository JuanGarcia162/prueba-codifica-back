using Microsoft.AspNetCore.Mvc;
using SalesDP.ProvisionalData.DTOs;
using SalesDP.Services.Services;

[ApiController]
[Route("api/[controller]")]
public class OrdersController : ControllerBase
{
    private readonly ISalesService _salesService;

    public OrdersController(ISalesService salesService)
    {
        _salesService = salesService;
    }

    [HttpGet("{custid}")]
    public async Task<IActionResult> GetOrdersBycustid(int custid)
    {
        var orders = await _salesService.GetOrdersBycustidAsync(custid);
        if (orders == null || orders.Count == 0)
        {
            return NotFound("No orders found for the given customer ID.");
        }
        return Ok(orders);
    }


    [HttpPost]
    public async Task<IActionResult> CreateOrder([FromBody] OrderCreateDto orderCreateDto)
    {
        if (orderCreateDto == null)
        {
            return BadRequest("Order data is required.");
        }

        await _salesService.CreateOrderAsync(orderCreateDto);
        return CreatedAtAction(nameof(CreateOrder), new { id = orderCreateDto.EmpID }, orderCreateDto);
    }
}
