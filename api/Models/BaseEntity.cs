using System;

namespace TecnologiasMovilesApi.Models
{
    public class BaseEntity
    {
        public DateTime Created { get; set; } = DateTime.Now;
        public DateTime? Deleted { get; set; } = null;
        public bool IsDeleted { get; set; } = false;
    }
}