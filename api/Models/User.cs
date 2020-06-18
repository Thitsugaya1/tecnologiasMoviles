using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TecnologiasMovilesApi.Models
{
    public class User
    {
        
        public string UserName { get; set; }
        public string Password { get; set; }
        [Key]
        public string Email { get; set; }
        public string Rol { get; set; } = "Cliente";
    }
    
    public class Profile
    {
        [Key][ForeignKey("User")] 
        public string UserMail { get; set; }
        public string NickName { get; set; }
        public User User { get; set; }
    }
}