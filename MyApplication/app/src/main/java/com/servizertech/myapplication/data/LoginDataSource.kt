package com.servizertech.myapplication.data

import com.servizertech.myapplication.data.model.LoggedInUser
import com.servizertech.myapplication.data.model.UserRol
import java.io.IOException

/**
 * Class that handles authentication w/ login credentials and retrieves user information.
 */
class LoginDataSource {

    fun login(username: String, password: String): Result<LoggedInUser> {
        try {
            // TODO: handle loggedInUser authentication
            var fakeUser = LoggedInUser(java.util.UUID.randomUUID().toString(), "Jane Doe", UserRol.User)

            if(username == "Admin" && password == "Admin1"){
                fakeUser = LoggedInUser("1", "Admin", UserRol.Admin);
            }

            return Result.Success(fakeUser)
        } catch (e: Throwable) {
            return Result.Error(IOException("Error logging in", e))
        }
    }

    fun logout() {
        // TODO: revoke authentication
    }
}

