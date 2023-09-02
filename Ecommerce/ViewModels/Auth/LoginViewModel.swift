//
//  LoginViewModel.swift
//  Fenix
//
//  Created by shotDeck_developer  on 31/12/21.
//

import Foundation
class LoginViewModel {
    
    func login(email: String, password: String, success: @escaping((LoginResponse) -> Void), failure: @escaping((LoginResponse?, ResponseStatus) -> Void)) {
        Common.shared.showHUD()
        let loginRequest = LoginRequest.init(email: email, password: password)
        _ = LoginNC.init().login(loginRequest: loginRequest, completion: {
            loginResponse, responseStatus in
            Common.shared.hideHUD()
            if loginResponse?.success == true {
                success(loginResponse!)
            }
            else {
                failure(loginResponse, responseStatus)
            }
        })
    }    
    
}
