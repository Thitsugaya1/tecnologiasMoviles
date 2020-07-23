using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.OpenApi.Extensions;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Services.Imp
{
    public class TicketService : ITicketService
    {

        private readonly IUserService _userService;
        private readonly IUnitOfWork _context;
        
        public TicketService(IUserService userService, IUnitOfWork context){
            _userService = userService;
            _context = context;
        }

        public Task<bool> CancelTicket(Ticket ticket)
        {
            throw new NotImplementedException();
        }

        public Task<bool> CancelTicketById(int id)
        {
            throw new NotImplementedException();
        }

        async public Task<IEnumerable<Ticket>> GetAllTickets()
        {
            return _context.Tickets.GetAll();
        }

        public Task<IEnumerable<Ticket>> GetTicketAssignedToUser(IdentityUser user)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Ticket>> GetTicket(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Ticket>> GetTicketsOfUser(IdentityUser user)
        {
            throw new NotImplementedException();
        }

        public Task<bool> UpdateTicket(Ticket ticket)
        {
            throw new NotImplementedException();
        }

        async public Task<bool> CreateTicketByUser(CreateTicketStub ticketStub, IdentityUser user)
        {
            var ticket = new Ticket();
			ticket.ClienteEmail = user.Id;
			ticket.DateTime = ticketStub.dateTime;
			ticket.Estado = Estado_Ticket.Pediente;
			ticket.HoraInicio = ticketStub.horaInicio;
			ticket.Comentario = ticketStub.comentario;
			var gps = new UbicacionGPS();
			gps.Latitud = ticketStub.direccion.latitud;
			gps.Longitud = ticketStub.direccion.longitud;
			gps.ReverseGeoCode = ticketStub.direccion.direccion;
			ticket.Direccion = gps;
			_context.Tickets.Add(ticket);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (System.Exception e)
            {
                //TODO: LOG ERROR RETURN A FAILURE;
                throw e;
            }
            return true;
        }

        public Task<bool> CreateTicketByUser(CreateTicketStub ticketStub, string clientEmail)
        {
            return CreateTicketByUser(ticketStub, (IdentityUser)_userService.GetUserByMail(clientEmail).Result);
        }

    }
}