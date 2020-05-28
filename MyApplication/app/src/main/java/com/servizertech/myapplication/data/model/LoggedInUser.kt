package com.servizertech.myapplication.data.model


enum class UserRol(val rolid: Number){
        Admin(1), User(5)
}

/**
 * Data class that captures user information for logged in users retrieved from LoginRepository
 */
data class LoggedInUser(
        val userId: String,
        val displayName: String,
        val userRol: UserRol
)
