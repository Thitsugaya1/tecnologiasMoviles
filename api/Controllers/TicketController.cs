using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SQLitePCL;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TicketController: ControllerBase
    {
        private readonly UnitOfWork _context;
       // private  readonly UserManager<IdentityUser> _userManger;

        public TicketController(IUnitOfWork unitOfWork, UserManager<IdentityUser> userManager)
        {
            _context = (UnitOfWork) unitOfWork;
        }

        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)] 
        [HttpPost]
        public async Task<IActionResult> CreateTicket(Ticket ticket)
        {
            var claim = User.Claims.Where(y => y.Type == ClaimTypes.Email).FirstOrDefault();
            var user = await _context.userManager.FindByEmailAsync(claim.Value);
            //var user = await _userManger.FindByEmailAsync(claim.Value);
            if (user == null) return NotFound("User Not Found");
            //ticket.ClienteEmail = user.Email;
            ticket.Cliente = user;
            _context.Tickets.Add(ticket);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpGet]
        public IEnumerable<Ticket> GetAll() => _context.Tickets.GetAll();
    }
}