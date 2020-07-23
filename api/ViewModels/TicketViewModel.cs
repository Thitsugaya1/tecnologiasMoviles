using System;

namespace TecnologiasMovilesApi.ViewModels
{
    public class CreateTicketStub{
        public DateTime dateTime {get; set;}
        public uint horaInicio {get; set; }
        public string comentario {get; set;}
        public CreateDireccionStub direccion {get; set;}
    }

    public class CreateDireccionStub{
        public double latitud {get; set;}
        public double longitud {get; set; }
        public string direccion {get; set; }
    }
}