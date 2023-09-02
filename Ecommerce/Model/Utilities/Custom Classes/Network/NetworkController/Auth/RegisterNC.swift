//
//  RegisterNC.swift
//  Fenix
//
//  Created by shotDeck_developer  on 29/12/21.
//

import Foundation

class RegisterNC: BaseNetworkController {
    
    func CreateSignupCode(createSingupCodeRequest: CreateSingupCodeRequest, completion: ((CreateSignupCodeResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestUrl = try RequestBuilder().getRequestObject(api: .signup) else {
                let errorMsg = "Unable to build request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestUrl.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(createSingupCodeRequest)
            return addOperation(request: requestUrl) {
                data, response, responseStatus in
                var createSignupCodeResponse: CreateSignupCodeResponse?
                if let data = data
                {
                    createSignupCodeResponse = BaseNetworkController.decodeData(data: data)
                    if createSignupCodeResponse?.success  == false {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(createSignupCodeResponse, responseStatus)
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion?(createSignupCodeResponse, responseStatus)
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(createSignupCodeResponse, responseStatus)
                    }
                }
            }
        }
        catch {
            return nil
        }
    }
    
    func VerifySignupCode(verifySignupCodeRequest: VerifySignupCodeRequest, completion: ((VerifySignupCodeResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestUrl = try RequestBuilder().getRequestObject(api: .signupVerify) else {
                let errorMsg = "Unable to build request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestUrl = requestUrl.appendQueryParams(queryPrams: verifySignupCodeRequest)!
            return addOperation(request: requestUrl) {
                data, response, responseStatus in
                var verifySignupCodeResponse: VerifySignupCodeResponse?
                if let data = data
                {
                    verifySignupCodeResponse = BaseNetworkController.decodeData(data: data)
                    if verifySignupCodeResponse?.success  == false {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(verifySignupCodeResponse, responseStatus)
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion?(verifySignupCodeResponse, responseStatus)
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(verifySignupCodeResponse, responseStatus)
                    }
                }
            }
        }
        catch {
            return nil
        }
    }
    
    func CreateSingupAccount(signupRequest: SignupRequest, completion: ((SignupResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestUrl = try RequestBuilder().getRequestObject(api: .signupAccount) else {
                let errorMsg = "Unable to build request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestUrl.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(signupRequest)
            return addOperation(request: requestUrl) {
                data, response, responseStatus in
                var signupResponse: SignupResponse?
                if let data = data
                {
                    signupResponse = BaseNetworkController.decodeData(data: data)
                    if signupResponse?.success  == false {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(signupResponse, responseStatus)
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion?(signupResponse, responseStatus)
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(signupResponse, responseStatus)
                    }
                }
                
            }
        }
        catch {
            return nil
        }
    }
    
    //MARK: -  Get Category API
    
    func getJobCategory(completion: ((GetJobCategoryResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestUrl = try RequestBuilder().getRequestObject(api: .getJobCategory) else {
                let errorMsg = "Unable to build request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            return addOperation(request: requestUrl) {
                data, response, responseStatus in
                var getJobCategoryResponse: GetJobCategoryResponse?
                if let data = data
                {
                    getJobCategoryResponse = BaseNetworkController.decodeData(data: data)
                    if getJobCategoryResponse?.success  == false {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(getJobCategoryResponse, responseStatus)
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion?(getJobCategoryResponse, responseStatus)
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(getJobCategoryResponse, responseStatus)
                    }
                }
            }
        }
        catch {
            return nil
        }
    }
    
    
}
