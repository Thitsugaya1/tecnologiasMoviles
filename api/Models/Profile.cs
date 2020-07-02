using Microsoft.AspNetCore.Identity;

namespace TecnologiasMovilesApi.Models
{
    public class Profile : BaseEntity
    {
        public IdentityUser IdentityUser { get; set; }
    }
}