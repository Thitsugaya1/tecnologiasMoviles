using System;

namespace TecnologiasMovilesApi.Models
{
    public class BaseEntity
    {
        public long Id { get; set; }
        public DateTime Created { get; set; }
        public DateTime? Deleted { get; set; } = null;
        public bool IsDeleted { get; set; }
    }
}