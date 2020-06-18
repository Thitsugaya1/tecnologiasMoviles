using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TecnologiasMovilesApi.Models
{
    public enum Estado_Ticket
    {
        Pediente,Aceptado,Cancelado,Rechazado
    }
    public class Ticket
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey("User")] 
        public string ClienteEmail { get; set; }
        public DateTime DateTime { get; set; }
        public User Cliente { get; set; }
        public uint HoraInicio { get; set; }
        public Estado_Ticket Estado { get; set; }
        public string Comentario { get; set; }
        [ForeignKey("UbicacionGPS")]
        public int DireccionId { get; set; }
        public UbicacionGPS Direccion { get; set; }
        
    }
}