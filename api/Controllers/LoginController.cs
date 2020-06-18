using System.Collections;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Utilities;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly UnitOfWork _context;
        public LoginController(ApplicationDbContext db) => _context = new UnitOfWork(db);

        
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)] 
        [HttpGet("all")]
        public IEnumerable<User> GetALl() => _context.Users.GetAll();

        [HttpGet]
        public string Login(string mail, string password)
        {
            User user = _context.Users[mail];
            return password.ToMD5().ToMD5() == user.Password ? TokenManager.GenerateToken(user) : string.Empty;
        }
        
        [HttpPost]
        public void Register(User user)
        {
            user.Password = user.Password.ToMD5().ToMD5();
            _context.Users.Add(user);
            _context.Complete();
        }
        
    }
}