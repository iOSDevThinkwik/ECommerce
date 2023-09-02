//
//  SignupViewModel.swift
//  SHOTDECK
//
//  Created by HEMANG SOLANKI on 18/11/22.
//

import Foundation

class SignupViewModel  {
    
//    var jobCategory = [GetJobCategoryData?]()
//    
//    func createSignupCode(email: String, success: @escaping((CreateSignupCodeResponse) -> Void), failure: @escaping((CreateSignupCodeResponse?, ResponseStatus) -> Void)) {
//        Common.shared.showHUD()
//        let createSingupCodeRequest = CreateSingupCodeRequest.init(email: email)
//        _ = RegisterNC.init().CreateSignupCode(createSingupCodeRequest: createSingupCodeRequest,completion: {
//            createSignupCodeResponse, responseStatus in
//            Common.shared.hideHUD()
//            if createSignupCodeResponse?.success == true {
//                success(createSignupCodeResponse!)
//            }else {
//                failure(createSignupCodeResponse, responseStatus)
//            }
//        })
//    }
//    
//    func verifySignupCode(ConfirmationCode: String, success: @escaping((VerifySignupCodeResponse) -> Void), failure: @escaping((VerifySignupCodeResponse?, ResponseStatus) -> Void)) {
//        Common.shared.showHUD()
//        let verifySignupCodeRequest = VerifySignupCodeRequest.init(confirmation_code:ConfirmationCode)
//        _ = RegisterNC.init().VerifySignupCode(verifySignupCodeRequest: verifySignupCodeRequest,completion: {
//            verifySignupCodeResponse, responseStatus in
//            Common.shared.hideHUD()
//            if verifySignupCodeResponse?.success == true {
//                success(verifySignupCodeResponse!)
//            }else {
//                failure(verifySignupCodeResponse, responseStatus)
//            }
//        })
//    }
//    
//    func createAccount(first_name:String?,last_name:String?,email:String?,password:String?,password_confirm:String?,industry:String?,industry_job:String?,industry_where:String?,website:String?,confirmation_code:String?,email_opt_in:String?, success: @escaping((SignupResponse) -> Void), failure: @escaping((SignupResponse?, ResponseStatus) -> Void)) {
//        Common.shared.showHUD()
//        let signupRequest = SignupRequest(first_name: first_name, last_name: last_name, email: email, password: password, password_confirm: password_confirm, industry: industry, industry_job: industry_job, industry_where: industry_where, website: website, email_opt_in: email_opt_in, confirmation_code: confirmation_code)
//        
//        _ = RegisterNC.init().CreateSingupAccount(signupRequest: signupRequest,completion: {
//            signupResponse, responseStatus in
//            Common.shared.hideHUD()
//            if signupResponse?.success == true {
//                success(signupResponse!)
//            }else {
//                failure(signupResponse, responseStatus)
//            }
//        })
//    }
//    
//    //MARK: - Get Job Category
//    
//    func getJobCategory(success: @escaping((GetJobCategoryResponse) -> Void), failure: @escaping((GetJobCategoryResponse?, ResponseStatus) -> Void)) {
//       // Common.shared.showHUD()
//        _ = RegisterNC.init().getJobCategory(completion: {
//            getJobCategoryResponse, responseStatus in
//            Common.shared.hideHUD()
//            self.jobCategory.removeAll()
//            if getJobCategoryResponse?.success == true {
//                self.jobCategory.append(contentsOf: getJobCategoryResponse!.data)
//                success(getJobCategoryResponse!)
//            }else {
//                failure(getJobCategoryResponse, responseStatus)
//            }
//        })
//    }
//    
}
