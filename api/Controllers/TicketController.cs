using System.Collections.Generic;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TicketController: ControllerBase
    {
        private readonly IUnitOfWork _context;
        public TicketController(IUnitOfWork unitOfWork) => _context = unitOfWork;
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)] 
        [HttpPost]
        public IActionResult CreateTicket(Ticket ticket)
        {
            _context.Tickets.Add(ticket);
            return Ok(_context.SaveChanges());
        }

        [HttpGet]
        public IEnumerable<Ticket> GetAll() => _context.Tickets.GetAll();
    }
}