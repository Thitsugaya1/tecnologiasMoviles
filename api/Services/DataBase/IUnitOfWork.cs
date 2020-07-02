using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase.Repository;

namespace TecnologiasMovilesApi.Services.DataBase
{
    public interface IUnitOfWork : IDisposable
    {
        //public Repository<User, string> Users { get; set; }
        //public Repository<Profile, string> Profiles { get; set; }
        public IRepository<Ticket,int> Tickets { get; set; }
        public IRepository<UbicacionGPS,int> UbicacionGPS { get; set; }
        public IRepository<IdentityUser, Guid> Users { get; set; }

        int SaveChanges();
        Task<int> SaveChangesAsync();
    }
}