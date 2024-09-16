using Microsoft.EntityFrameworkCore;
using SalesDP.Data.Models;

namespace SalesDP.Data.Data
{
    public class StoreSampleContext : DbContext
    {
        public StoreSampleContext(DbContextOptions<StoreSampleContext> options)
            : base(options) { }

        public DbSet<Customer> Customers { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<Shipper> Shippers { get; set; }
        public DbSet<Product> Products { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Employee>()
                .HasKey(e => e.EmpID);

            modelBuilder.Entity<Customer>()
            .HasKey(c => c.CustomerID);

        }
    }

}
