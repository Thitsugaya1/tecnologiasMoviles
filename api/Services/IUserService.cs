using System.Threading.Tasks;
using TecnologiasMovilesApi.ViewModels;

namespace PS3_PS4CheatDatabaseRepositoryApi.Services
{
    public interface IUserService
    {
        Task<ResponseViewModel> RegisterUserAsync(RegisterViewModel model);
        Task<ResponseViewModel> LoginUserAsync(LoginViewModel model);
        Task<ResponseViewModel> ConfirmEmailAsync(string email, string token);
        Task<ResponseViewModel> ForgetPasswordAsync(string email);
        Task<ResponseViewModel> ResetPasswordAsync(RegisterViewModel model, string token);
    }
}
