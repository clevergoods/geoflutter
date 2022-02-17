package com.wokkalokka.clevergoods.models

import io.objectbox.annotation.Entity
import io.objectbox.annotation.Id

@Entity()
data class ObjectboxAUserModel(

    var login: String? = null,
    var password: String? = null,

){
    @Id
    var id: Long = 0
    var email: String? = null
    var name: String? = null
    var photoUrl: String? = null
    var appVersion: String? = null
    var phone: String? = null
    var platform: String? = null
    var sessionid: Int? = null

}

