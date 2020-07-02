using System.Threading.Tasks;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Services
{
    public interface IMailService
    {
        Task<ResponseViewModel> SendAsync(string toEmail, string subject, string content);
        Task<ResponseViewModel> SendConfirmationEmailAsync(string mail, string token);
        Task<ResponseViewModel> SendPasswordResetAsync(string mail, string token);
    }
}