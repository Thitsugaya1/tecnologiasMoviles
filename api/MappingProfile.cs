using AutoMapper;
using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<IdentityUser, UserViewModel>()
                .ForMember(o => o.Email , p => p.MapFrom(d => d.Email))
                .ForMember(o => o.UserName , p => p.MapFrom(d => d.UserName))
                .ForAllOtherMembers(o=>o.Ignore());
        }
    }
}