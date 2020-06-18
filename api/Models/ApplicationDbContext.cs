using Microsoft.EntityFrameworkCore;

namespace TecnologiasMovilesApi.Models
{
    /// <summary>
    /// Database Connection
    /// </summary>
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Profile> Profiles { get; set; }
        public DbSet<Ticket> Tickets { get; set; }
        public DbSet<UbicacionGPS> UbicacionGPS { get; set; }
    }
}