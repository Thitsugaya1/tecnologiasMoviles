using System.Collections.Generic;
using AutoMapper;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase;
using TecnologiasMovilesApi.Services;
using System;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("Api/[controller]")]
    public class TicketController: ControllerBase
    {
        private readonly IUnitOfWork _context;
		private readonly IUserService _userService;
		private readonly ITicketService _ticketService;
        public TicketController(IUnitOfWork unitOfWork, IUserService userService, ITicketService ticketService) { 
			_context = unitOfWork;
			_userService = userService;	
			_ticketService = ticketService;
		}
        
        [Authorize][HttpPost]
        public IActionResult CreateTicket(CreateTicketStub stub)
        {
            return Ok(_ticketService.CreateTicketByUser(stub, User.Identity.Name).Result);
        }

        [HttpGet]
        public IEnumerable<Ticket> GetAll() {
			return _ticketService.GetAllTickets().Result;
		}

       
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
