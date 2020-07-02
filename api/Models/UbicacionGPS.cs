namespace TecnologiasMovilesApi.Models
{
    public class UbicacionGPS : BaseEntity
    {
        public int Id { get; set; }
        public double Latitud { get; set; }
        public double Longitud { get; set; }
        public string ReverseGeoCode { get; set; }
    }
}