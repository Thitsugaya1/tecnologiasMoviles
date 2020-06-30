using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase.Repository;

namespace TecnologiasMovilesApi.Services.DataBase
{
    public class UnitOfWork: IUnitOfWork
    {
        
        private readonly ApplicationDbContext _context;

        public UserManager<IdentityUser> userManager;
        public IRepository<Ticket, int> Tickets { get; set; }
        public IRepository<UbicacionGPS, int> UbicacionGPS { get; set; }
        
        public UnitOfWork(ApplicationDbContext context, UserManager<IdentityUser> _userManager)
        {
            _context = context;
            userManager = _userManager;
            Tickets = new Repository<Ticket, int>(_context);
            UbicacionGPS = new Repository<UbicacionGPS, int>(_context);
        }
        //public Repository<User, string> Users { get; set; }
        //public Repository<Profile, string> Profiles { get; set; }

        public int SaveChanges() => _context.SaveChanges();
        public Task<int> SaveChangesAsync() => _context.SaveChangesAsync();
        public void Dispose() => _context.Dispose();
    }
}