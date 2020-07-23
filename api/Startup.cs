using AutoMapper;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SQLitePCL;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services;
using TecnologiasMovilesApi.Services.DataBase;
using TecnologiasMovilesApi.Services.DataBase.Repository;
using TecnologiasMovilesApi.Services.Imp;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
          
            Mapper.Initialize(cfg => cfg.AddProfile<MappingProfile>());
            services.AddAutoMapper();
            services.AddDbContext<ApplicationDbContext>(opt => opt.UseSqlite("Data Source=dataBaseApi.db"));
            services.AddCors();
            services.AddAuthenticationConfiguration(Configuration["Jwt:key"]);
            services.AddScoped<IUnitOfWork,UnitOfWork>();
            services.AddScoped<IMailService, MailService>();
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IUnitOfWork,UnitOfWork>();
            services.AddScoped<ITicketService, TicketService>();
            services.AddSwaggerDocumentation(); //Swagger
            services.AddControllers();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ApplicationDbContext context)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            app.UseCors(x => x
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());
            
            //app.UseHttpsRedirection();
            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseSwaggerDocumentation();
            context.Database.EnsureCreated();
            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
        }
    }
}