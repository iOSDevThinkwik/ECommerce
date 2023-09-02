//
//  ForgotPasswordModel.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 30/12/22.
//

import Foundation

class ForgotPasswordModel {
    
    func forgotPassword(email: String, success: @escaping((ForgotPasswordResponse) -> Void), failure: @escaping((ForgotPasswordResponse?, ResponseStatus) -> Void)) {
        Common.shared.showHUD()
        let forgotPasswordRequest = ForgotPasswordRequest.init(email: email)
        _ = ForgotPasswordNC.init().forgotPassword(forgotPasswordRequest: forgotPasswordRequest, completion: {
            forgotPasswordResponse, responseStatus in
            Common.shared.hideHUD()
            if forgotPasswordResponse?.success == true {
                success(forgotPasswordResponse!)
            }
            else {
                failure(forgotPasswordResponse, responseStatus)
            }
        })
    }
    
}
