using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using TecnologiasMovilesApi.Models;

namespace TecnologiasMovilesApi.Services.DataBase.Repository
{
    public class TicketRepository : Repository<Ticket,int>
    {
        public TicketRepository(ApplicationDbContext context) : base(context) { }
        public override Ticket Get(int key)
            => Context.Tickets.Include(d => d.Direccion)
                .Include(i => i.Images)
                .Include(a => a.Audios)
                .SingleOrDefault(k => k.Id == key);
        public override IEnumerable<Ticket> GetAll()
            => Context.Tickets.Include(d => d.Direccion)
                .Include(i => i.Images)
                .Include(a => a.Audios);

        public void AddImage(int key, Image img) => Context.Tickets.Find(key).Images.Add(img);
        public void AddAudio(int key, Audio audio) => Context.Tickets.Find(key).Audios.Add(audio);
        public void AddImages(int key, IEnumerable<Image> images) => Context.Tickets.Find(key).Images.AddRange(images);
        public void AddAudios(int key, IEnumerable<Audio> audios) => Context.Tickets.Find(key).Audios.AddRange(audios);
    }
}