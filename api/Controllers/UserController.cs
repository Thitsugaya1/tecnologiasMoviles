using System;
using System.Collections.Generic;
using System.Linq;
using AutoMapper;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using TecnologiasMovilesApi.Services;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("Api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService) => _userService = userService;

        //ActionResult<UserViewModel>
        [Authorize]
        [HttpGet]
        public ActionResult<UserViewModel> GetUser() 
            =>Ok(Mapper.Map<UserViewModel>(_userService.GetUserByMail(User.Identity.Name).Result));

        //[Authorize]
        [HttpPut]
        public ActionResult<UserViewModel> UpdateUser()
        {
            throw new  NotImplementedException();
        }
        
        //[Authorize(Roles = "Administrador")]
        [HttpGet("All")]
        public ActionResult<IEnumerable<UserViewModel>> GetAllUser()
            =>Ok(Mapper.Map<IEnumerable<UserViewModel>>(_userService.GetAllUsers().Result));
        

        //[Authorize(Roles = "Administrador")]
        [HttpGet("{mail}")]
        public ActionResult<IEnumerable<UserViewModel>> GetUserByMail(string mail) 
            => Ok(Mapper.Map<UserViewModel>(_userService.GetUserByMail(mail).Result));
        
        //[Authorize(Roles = "Administrador")]
        [HttpGet("AllMails")]
        public ActionResult<IEnumerable<string>> GetAllUserMail()
            => Ok(_userService.GetAllUserMail().Result);
        
        [Authorize]
        [HttpGet("Claims")]
        public object Claims() => User.Claims.Select(c => new {Type = c.Type, Value = c.Value});

    }
}