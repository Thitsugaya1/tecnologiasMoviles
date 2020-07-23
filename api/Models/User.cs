using Microsoft.AspNetCore.Identity;
using Microsoft.OpenApi.Extensions;

namespace TecnologiasMovilesApi.Models
{
    public class User : IdentityUser
    { 
        public string Rol { get; set; } = UserRol.Cliente.GetDisplayName();
    }
}