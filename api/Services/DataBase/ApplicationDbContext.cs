using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using TecnologiasMovilesApi.Models;

namespace TecnologiasMovilesApi.Services.DataBase
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public DbSet<User> Users { get; set; }
        //public DbSet<Profile> Profiles { get; set; }
        public DbSet<Ticket> Tickets { get; set; }
        public DbSet<UbicacionGPS> UbicacionGPS { get; set; }
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        
    }
}