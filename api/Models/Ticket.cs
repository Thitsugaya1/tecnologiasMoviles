using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;

namespace TecnologiasMovilesApi.Models
{
    public enum Estado_Ticket
    {
        Pediente,Aceptado,Cancelado,Rechazado
    }
    public class Ticket : BaseEntity
    {
        [Key]
        public int Id { get; set; }
        
        public DateTime DateTime { get; set; }
        [ForeignKey("IdentityUser")]
        public string ClienteEmail { get; set; }
        //public IdentityUser Cliente { get; set; }
        public uint HoraInicio { get; set; }
        public Estado_Ticket Estado { get; set; } = Estado_Ticket.Pediente;
        public string Comentario { get; set; }
        [ForeignKey("UbicacionGPS")]
        public int DireccionId { get; set; }
        public UbicacionGPS Direccion { get; set; }
        public List<Image> Images { get; set; } = new List<Image>();
        public List<Audio> Audios { get; set; } = new List<Audio>();
        
    }
}