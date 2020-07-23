using System.Collections.Generic;
using AutoMapper;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("Api/[controller]")]
    public class TicketController: ControllerBase
    {
        private readonly IUnitOfWork _context;
        public TicketController(IUnitOfWork unitOfWork) => _context = unitOfWork;
        
        [Authorize][HttpPost]
        public IActionResult CreateTicket(Ticket ticket)
        {
            ticket.ClienteEmail = User.Identity.Name;
            _context.Tickets.Add(ticket);
            return Ok(_context.SaveChanges());
        }

        [HttpGet]
        public IEnumerable<Ticket> GetAll() => _context.Tickets.GetAll();
       
        [HttpGet("{id}")]
        public ActionResult<Ticket> Get(int id) => Ok(_context.Tickets[id]);
        
        [HttpPost("estado")]
        public IActionResult SetEstado(int id, Estado_Ticket estado)
        {
            var result = _context.Tickets[id];
            if (result == null) return NotFound();
            result.Estado = estado;
            _context.SaveChanges();
            return Ok();
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id, Ticket ticketPoco)
        {
            var ticket = _context.Tickets[id];
            Mapper.Map(ticketPoco, ticket);
            _context.SaveChanges();
            return Ok();
        }
    }
}