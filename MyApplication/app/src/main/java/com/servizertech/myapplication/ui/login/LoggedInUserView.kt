package com.servizertech.myapplication.ui.login

import com.servizertech.myapplication.data.model.UserRol

/**
 * User details post authentication that is exposed to the UI
 */
data class LoggedInUserView(
        val displayName: String,
        val userRol: UserRol
        //... other data fields that may be accessible to the UI
)
