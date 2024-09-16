namespace SalesDP.ProvisionalData.DTOs
{
    public class OrderCreateDto
    {
        public int EmpID { get; set; }
        public int ShipperID { get; set; }
        public string ShipName { get; set; }
        public string ShipAddress { get; set; }
        public string ShipCity { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime RequiredDate { get; set; }
        public DateTime? ShippedDate { get; set; }
        public decimal Freight { get; set; }
        public string ShipCountry { get; set; }
        public decimal UnitPrice { get; set; }
        public int Qty { get; set; }
        private decimal _discount;
        public decimal Discount
        {
            get => _discount;
            set => _discount = Math.Max(0, Math.Min(1, value));
        }
        public int ProductID { get; set; }
        public int CustomerID { get; set; }
    }

}
