using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SQLitePCL;
using TecnologiasMovilesApi.Models;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TicketController: ControllerBase
    {
        private readonly UnitOfWork _context;
        public TicketController(ApplicationDbContext db) => _context = new UnitOfWork(db);
        
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)] 
        [HttpPost]
        public void CreateTicket(Ticket ticket)
        {
            var claim = User.Claims.Where(y => y.Type == ClaimTypes.Email).FirstOrDefault();
            ticket.ClienteEmail = claim.Value;
            ticket.Cliente = _context.Users[claim.Value];
            _context.Tickets.Add(ticket);
            _context.Complete();
        }

        [HttpGet]
        public IEnumerable<Ticket> GetAll() => _context.Tickets.GetAll().Include(x => x.Direccion).Include(x=> x.Cliente);
    }
}