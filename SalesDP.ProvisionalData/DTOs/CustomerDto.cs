namespace SalesDP.ProvisionalData.DTOs
{
    public class CustomerDto
    {
        public int custid { get; set; }
        public string CompanyName { get; set; }
        public DateTime LastOrderDate { get; set; }
        public DateTime NextPredictedOrder { get; set; }
    }

}
