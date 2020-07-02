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
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Services.Imp
{
    public class UserService : IUserService
    {
        private readonly UserManager<IdentityUser> _userManger;
        private readonly IMailService _mailService;
        private readonly IConfiguration _configuration;
        private RoleManager<IdentityRole> _roleManager;

        public UserService(UserManager<IdentityUser> userManager, IMailService mailService, IConfiguration configuration, RoleManager<IdentityRole> role)
        {
            _roleManager = role;
            _userManger = userManager;
            _mailService = mailService;
            _configuration = configuration;
            
            /*
            role.CreateAsync(new IdentityRole(UserRol.Administrador.GetDisplayName()));
            role.CreateAsync(new IdentityRole(UserRol.Cliente.GetDisplayName()));
            role.CreateAsync(new IdentityRole(UserRol.Huesped.GetDisplayName()));*/
            

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
            //await _userManger.AddToRoleAsync(user, UserRol.Cliente.GetDisplayName());
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
        public Task<IdentityUser> GetUserByMail(string mail) => _userManger.FindByEmailAsync(mail);
        public async Task<IEnumerable<IdentityUser>> GetAllUsers() => await _userManger.Users.ToListAsync();

        public async Task<IEnumerable<string>> GetAllUserMail()
            => await _userManger.Users.Select(x => x.Email).ToListAsync();
        public async Task<ResponseViewModel> AddRol(string mail, UserRol rol)
        {
            var user = await _userManger.FindByEmailAsync(mail);
            var result = await _userManger.AddToRoleAsync(user, rol.GetDisplayName());
            return result.Succeeded
                ? new ResponseViewModel($"{rol.GetDisplayName()} added", true)
                : new ResponseViewModel("Something went wrong", false,
                    result.Errors.Select(e => e.Description));
        }
    }
}
