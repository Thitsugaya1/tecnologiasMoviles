using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.ViewModels;
using Profile = AutoMapper.Profile;

namespace TecnologiasMovilesApi
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<User, UserViewModel>()
                .ForMember(o => o.Email , p => p.MapFrom(d => d.Email))
                .ForMember(o => o.UserName , p => p.MapFrom(d => d.UserName))
                .ForMember(o => o.Rol, p => p.MapFrom(d => d.Rol))
                .ForAllOtherMembers(o=>o.Ignore());
            ;
            CreateMap<UserViewModel, IdentityUser>()
                .ForAllMembers(o => o.Condition((src, dest, srcMember) => srcMember != null));
            ;

            CreateMap<Ticket, Ticket>()
                .ForMember(o => o.Id, p => p.Ignore())
                .ForMember(o => o.DireccionId, p => p.Ignore())
                .ForAllOtherMembers(o => o.Condition((src, dest, srcMember) => srcMember != null));
        }
    }
}