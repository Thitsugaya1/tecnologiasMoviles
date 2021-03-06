using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Principal;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Extensions;
using TecnologiasMovilesApi.Models;
using TecnologiasMovilesApi.Services.DataBase;
using TecnologiasMovilesApi.ViewModels;

namespace TecnologiasMovilesApi
{
    public static class TokenManager
    {

        public static IServiceCollection AddAuthenticationConfiguration(this IServiceCollection services, string secret)
        {
            services.AddIdentity<User, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();
            
            /*
            services.Configure<IdentityOptions>(o => 
            {
                o.SignIn.RequireConfirmedEmail = true;
            });*/

            byte[] key = Convert.FromBase64String(secret);
            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(options =>
            {
                options.SaveToken = true;
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    RequireExpirationTime = true,
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero,
                    IssuerSigningKey = new SymmetricSecurityKey(key)
                };
            });
            return services;
        }

        public static TokenViewModel GenerateToken(this string email, string secret, string rol)
        {
            
            byte[] key = Convert.FromBase64String(secret);
            SymmetricSecurityKey securityKey = new SymmetricSecurityKey(key);
            SecurityTokenDescriptor descriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity( new []
                {
                    new Claim(ClaimTypes.Name, email),
                    new Claim(ClaimTypes.Role, rol)
                }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(securityKey,
                    SecurityAlgorithms.HmacSha256Signature)
            };
            JwtSecurityTokenHandler handler = new JwtSecurityTokenHandler();
            JwtSecurityToken token = handler.CreateJwtSecurityToken(descriptor);

            return new TokenViewModel
            {
                Token = handler.WriteToken(token),
                IssuedAt = DateTime.UtcNow,
                ExpireDate = descriptor.Expires
            };
        }
    }
}
