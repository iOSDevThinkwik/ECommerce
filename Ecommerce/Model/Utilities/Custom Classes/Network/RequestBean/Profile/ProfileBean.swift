//
//  ProfileBean.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation

// Change Password
struct ChangePasswordRequest: Codable {
    let email,password,new_password,new_password_confirm: String?
}

struct UpdateAccountRequest: Codable{
    let first_name,last_name: String?
    let email: String?
    //let email_opt_in: Bool?
}
