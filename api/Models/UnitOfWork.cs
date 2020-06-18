using System;
using TecnologiasMovilesApi.Repository;

namespace TecnologiasMovilesApi.Models
{
    public class UnitOfWork: IDisposable
    {
        private readonly ApplicationDbContext _context;
        public Repository<User, string> Users { get; set; }
        public Repository<Profile, string> Profiles { get; set; }
        public Repository<Ticket,int> Tickets { get; set; }
        public Repository<UbicacionGPS,int> UbicacionGPS { get; set; }
        public UnitOfWork(ApplicationDbContext context)
        {
            _context = context;
            Users = new Repository<User, string>(context);
            Profiles = new Repository<Profile, string>(context);
            Tickets = new Repository<Ticket, int>(context);
            UbicacionGPS = new Repository<UbicacionGPS, int>(context);
            
        }
        /// <summary>
        /// Save changes to the DB
        /// </summary>
        public int Complete() => _context.SaveChanges();
        
        public void Dispose() => _context.Dispose();
    }
}