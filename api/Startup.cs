using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using PS3_PS4CheatDatabaseRepositoryApi.Services;
using PS3_PS4CheatDatabaseRepositoryApi.Services.Imp;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase;
using TecnologiasMovilesApi.Services.Imp;

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
            //SQLite DbConfifuration
            services.AddDbContext<ApplicationDbContext>(opt => opt.UseSqlite("Data Source=dataBaseApi.db"));
            // Add CORS policy
            services.AddCors();
            services.AddAuthenticationConfiguration(Configuration["Jwt:key"]);
            services.AddScoped<IUnitOfWork,UnitOfWork>();
            services.AddScoped<IMailService, MailService>();
            services.AddScoped<IUserService, UserService>();
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
            app.UseAuthorization();
            app.UseSwaggerDocumentation();
            context.Database.EnsureCreated();
            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
        }
    }
}