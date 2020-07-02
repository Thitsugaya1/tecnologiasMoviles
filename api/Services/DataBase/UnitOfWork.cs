using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase.Repository;

namespace TecnologiasMovilesApi.Services.DataBase
{
    public class UnitOfWork: IUnitOfWork
    {
        
        private readonly ApplicationDbContext _context;
        
        public IRepository<Ticket, int> Tickets { get; set; }
        public IRepository<UbicacionGPS, int> UbicacionGPS { get; set; }
        public IRepository<IdentityUser, Guid> Users { get; set; }
        
        public UnitOfWork(ApplicationDbContext context)
        {
            _context = context;
            Users = new Repository<IdentityUser, Guid>(_context);
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