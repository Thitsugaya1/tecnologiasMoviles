using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using TecnologiasMovilesApi.ViewModels;

namespace PS3_PS4CheatDatabaseRepositoryApi.Services.Imp
{
    public class MailService : IMailService
    {
        private readonly IConfiguration _configuration;

        public MailService(IConfiguration configuration) => _configuration = configuration;
        
        //TODO:
        public async Task<ResponseViewModel> SendAsync(string toEmail, string subject, string content)
        {
            return new ResponseViewModel($"{toEmail}\n{subject}\n{content}", true);
        }

        public async Task<ResponseViewModel> SendConfirmationEmailAsync(string mail, string token)
        {
            //string url = $"{_configuration["AppUrl"]}/api/auth/confirmemail?userid={mail}&token={token}";
            return await SendAsync(mail,
                "Confirm your email", token);
        }

        public async Task<ResponseViewModel> SendPasswordResetAsync(string mail, string token)
        {
            //string url = $"{_configuration["AppUrl"]}/ResetPassword?email={mail}&token={token}";
            return await SendAsync(mail, "Reset Password", token);
        }
    }
}