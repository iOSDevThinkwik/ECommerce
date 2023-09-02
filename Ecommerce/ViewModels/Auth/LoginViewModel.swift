//
//  LoginViewModel.swift
//  Fenix
//
//  Created by HEMANG SOLANKI  on 31/12/21.
//

import Foundation


class LoginViewModel {
    
    var dashBoardData: Message?
    
    func login(email: String, password: String, success: @escaping((LoginResponse) -> Void), failure: @escaping((LoginResponse?, ResponseStatus) -> Void)) {
//        Common.shared.showHUD()
        let loginRequest = LoginRequest.init(email: email, password: password)
        _ = LoginNC.init().login(loginRequest: loginRequest, completion: {
            loginResponse, responseStatus in
            Common.shared.hideHUD()
            if loginResponse?.statusCode == 200 {
                success(loginResponse!)
            }
            else {
                failure(loginResponse, responseStatus)
            }
        })
    }
    
    func setDeleteToken(success: @escaping(() -> Void), failure: @escaping((LogoutResponse?, ResponseStatus) -> Void)) {
//            Common.shared.showHUD()
        _ = LogoutNC.init().deleteToken(completion: {
            deleteTokenResponse, responseStatus in
            Common.shared.hideHUD()
            if deleteTokenResponse?.statusCode == 200 {
                success()
            }
            else {
                failure(deleteTokenResponse, responseStatus)
            }
        })
    }
    
    func GetDashboard(success: @escaping(() -> Void), failure: @escaping((Dashboardresponse?, ResponseStatus) -> Void)) {
//            Common.shared.showHUD()
        _ = LogoutNC.init().dashBoard(completion: {
            dashboardresponse, responseStatus in
            Common.shared.hideHUD()
            if dashboardresponse?.statusCode == 200 {
                success()
            }
            else {
                failure(dashboardresponse, responseStatus)
            }
        })
    }
    
}
