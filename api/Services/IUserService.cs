using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Services
{
    public interface IUserService
    {
        Task<ResponseViewModel> RegisterUserAsync(RegisterViewModel model);
        Task<ResponseViewModel> LoginUserAsync(LoginViewModel model);
        Task<ResponseViewModel> ConfirmEmailAsync(string email, string token);
        Task<ResponseViewModel> ForgetPasswordAsync(string email);
        Task<ResponseViewModel> ResetPasswordAsync(RegisterViewModel model, string token);
        Task<User> GetUserByMail(string mail);
        Task<IEnumerable<User>> GetAllUsers();
        Task<IEnumerable<string>> GetAllUserMail();
        Task<ResponseViewModel> AddRol(string mail, UserRol rol);
        Task<ResponseViewModel> Update(User user);
    }
}
