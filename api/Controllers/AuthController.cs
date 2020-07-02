using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using TecnologiasMovilesApi.Services;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi.Controllers
{
    [ApiController]
    [Route("Api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IConfiguration _configuration;

        public AuthController(IUserService userService, IConfiguration configuration)
        {
            _userService = userService;
            _configuration = configuration;
        }

        [HttpPost("Register")]
        public async Task<ActionResult<ResponseViewModel>> RegisterAsync(RegisterViewModel model)
        {
            if (!ModelState.IsValid) return BadRequest("Some properties are not valid"); // Status code: 400
            var result = await _userService.RegisterUserAsync(model);
            return result.Success ? (ActionResult<ResponseViewModel>) Ok(result) : BadRequest(result);
        }

				// I'm creating a new token, So I'm *post*ing a new auth. 
        [HttpPost]
        public async Task<ActionResult<ResponseViewModel>> LoginAsync(LoginViewModel model)
        {
            if (!ModelState.IsValid) return BadRequest("Some properties are not valid");
            var result = await _userService.LoginUserAsync(model);
            return result.Success ? (ActionResult<ResponseViewModel>) Ok(result) : BadRequest(result);
        }
        
        
        [HttpGet("ConfirmEmail")]
        public async Task<ActionResult<ResponseViewModel>> ConfirmEmail(string mail, string token)
        {
            if (string.IsNullOrWhiteSpace(mail) || string.IsNullOrWhiteSpace(token)) return NotFound();
            var result = await _userService.ConfirmEmailAsync(mail, token);
            return result.Success ? (ActionResult<ResponseViewModel>) Ok(result) : BadRequest(result);
            //return result.Success ? (ActionResult<ResponseViewModel>) Redirect($"{_configuration["AppUrl"]}/ConfirmEmail.html") : BadRequest(result);
        }

        [HttpPost("ForgetPassword")]
        public async Task<ActionResult<ResponseViewModel>> ForgetPassword(string email)
        {
            if (string.IsNullOrEmpty(email)) return NotFound();
            var result = await _userService.ForgetPasswordAsync(email);
            return result.Success ? (ActionResult<ResponseViewModel>) Ok(result) : BadRequest(result);
        }
        
        [HttpPost("ResetPassword")]
        public async Task<ActionResult<ResponseViewModel>> ResetPassword(RegisterViewModel model, string token)
        {
            if (!ModelState.IsValid) return BadRequest("Some properties are not valid");
            var result = await _userService.ResetPasswordAsync(model,token);
            return result.Success ? (ActionResult<ResponseViewModel>) Ok(result) : BadRequest(result);
        }

    }
}
