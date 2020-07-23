using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Services
{
    public interface ITicketService {
        Task<IEnumerable<Ticket>> GetTicket(int id);
        Task<IEnumerable<Ticket>> GetTicketsOfUser(IdentityUser user);
        Task<IEnumerable<Ticket>> GetAllTickets();
        Task<IEnumerable<Ticket>> GetTicketAssignedToUser(IdentityUser user);
        Task<bool> UpdateTicket(Ticket ticket);
        Task<bool> CancelTicket(Ticket ticket);
        Task<bool> CancelTicketById(int id);
        Task<bool> CreateTicketByUser(CreateTicketStub ticketStub, string clientEmail);
        Task<bool> CreateTicketByUser(CreateTicketStub ticketStub, IdentityUser user);
    }
}