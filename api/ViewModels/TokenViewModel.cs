using System;

namespace TecnologiasMovilesApi.ViewModels
{
    public class TokenViewModel
    {
        public string Token { get; set; }
        public DateTime? IssuedAt { get; set; }
        public DateTime? ExpireDate { get; set; }
    }
}