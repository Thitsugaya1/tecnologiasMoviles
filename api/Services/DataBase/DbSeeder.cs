using Microsoft.AspNetCore.Identity;
using TecnologiasMovilesApi.Models;
public static class DbSeeder {
    public static void Seedusers(UserManager<IdentityUser> userManager){
        AddUser(userManager, "kain@w40k.net", "Kaine1_", UserRol.Administrador);
        AddUser(userManager, "client@w40k.net", "Client1_", UserRol.Cliente);        
    }

    private static void AddUser(UserManager<IdentityUser> userManager, string email, string password, UserRol role){
        var exists = userManager.FindByEmailAsync(email).Result;
        if(exists != null){
            return;
        }

        var user = new IdentityUser{
            UserName = email,
            Email = email,
            EmailConfirmed = true
        };
        IdentityResult result = userManager.CreateAsync(user, password).Result;
        if(result.Succeeded){
            userManager.AddToRoleAsync(user, role.ToString("G")).Wait();
        }
        else{
            throw new System.Exception("Failed to seed user" + email );
        }
    }

    public static void SeedRoles(RoleManager<IdentityRole> roleManager){
        foreach(UserRol role in System.Enum.GetValues(typeof(UserRol))){
            AddRole(roleManager, role);
        }
    }

    private static void AddRole(RoleManager<IdentityRole> roleManager, UserRol role){
        var exist = roleManager.FindByNameAsync(role.ToString("g")).Result;
        if(exist == null){
            IdentityResult res = roleManager.CreateAsync( new IdentityRole{ Name = role.ToString("G") }).Result;
            if(res.Succeeded == false){
                throw new System.Exception("Error Creating Role");
            }
        }
    }


}