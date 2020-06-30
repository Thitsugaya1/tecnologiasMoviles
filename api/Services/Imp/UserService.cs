using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using PS3_PS4CheatDatabaseRepositoryApi.Services;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Services.Imp
{
    public class UserService : IUserService
    {
        private readonly UserManager<IdentityUser> _userManger;
        private readonly IMailService _mailService;
        private readonly IConfiguration _configuration;

        public UserService(UserManager<IdentityUser> userManager, IMailService mailService, IConfiguration configuration)
        {
            _userManger = userManager;
            _mailService = mailService;
            _configuration = configuration;
        }

        public async Task<ResponseViewModel> RegisterUserAsync(RegisterViewModel model)
        {
            if (model == null) throw new NullReferenceException("Register Model is null");
            if (model.Password != model.ConfirmPassword)
                return new ResponseViewModel("Confirm password doesn't match the password", false);
            var user = new IdentityUser
            {
                Email = model.Email,
                UserName = model.UserName,
            };
            var result = await _userManger.CreateAsync(user, model.Password);
            return result.Succeeded
                ? await _mailService.SendConfirmationEmailAsync(user.Email,
                    await _userManger.GenerateEmailConfirmationTokenAsync(user))
                : new ResponseViewModel("User did not create",
                    false,
                    result.Errors.Select(e => e.Description));
        }

        public async Task<ResponseViewModel> LoginUserAsync(LoginViewModel model)
        {
            var user = await _userManger.FindByEmailAsync(model.Email);
            if (user == null) return new ResponseViewModel("There is no user with that Email address", false);
            var result = await _userManger.CheckPasswordAsync(user, model.Password);
            return result? 
                new ResponseViewModel(user.Email.GenerateToken(_configuration["Jwt:Key"]), true):
                new ResponseViewModel("Invalid password", false);
        }

        public async Task<ResponseViewModel> ConfirmEmailAsync(string email, string token)
        {
            var user = await _userManger.FindByEmailAsync(email);
            if (user == null) return new ResponseViewModel("User not found", false);
            var result = await _userManger.ConfirmEmailAsync(user, token);
            return result.Succeeded
                ? new ResponseViewModel("Email confirmed successfully!", true)
                : new ResponseViewModel("Email did not confirm", false,
                    result.Errors.Select(e => e.Description));
        }

        public async Task<ResponseViewModel> ForgetPasswordAsync(string email)
        {
            var user = await _userManger.FindByEmailAsync(email);
            if (user == null) return new ResponseViewModel("User not found", false);
            return await _mailService.SendPasswordResetAsync(email, await _userManger.GeneratePasswordResetTokenAsync(user));
        }

        public async Task<ResponseViewModel> ResetPasswordAsync(RegisterViewModel model, string token)
        {
            var user = await _userManger.FindByEmailAsync(model.Email);
            if (user == null) return new ResponseViewModel("No user associated with email", false);

            if (model.Password != model.ConfirmPassword)
                return new ResponseViewModel("Password doesn't match its confirmation", false);

            var result = await _userManger.ResetPasswordAsync(user, token, model.Password);
            return result.Succeeded
                ? new ResponseViewModel("Password has been reset successfully!", true)
                : new ResponseViewModel("Something went wrong", false,
                    result.Errors.Select(e => e.Description));
        }
    }
}
