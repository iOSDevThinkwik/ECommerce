//
//  LoginController.swift
//  NSUrlSession+RequestBuilder
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation
class LoginNC: BaseNetworkController {
    
    func login(loginRequest: LoginRequest, completion: ((LoginResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestUrl = try RequestBuilder().getRequestObject(api: .login) else {
                let errorMsg = "Unable to build request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestUrl.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(loginRequest)
            
            return addOperation(request: requestUrl, jsonPath: .login) {
                data, urlResponse, status in
                var loginInformation: LoginResponse?
                if let data = data
                {
                    loginInformation = BaseNetworkController.decodeData(data: data)
                    
                    if loginInformation?.statusCode != 200 {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(loginInformation, status)
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion?(loginInformation, status)
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(loginInformation, status)
                    }
                }
            }
        }
        catch {
            return nil
        }
    }
    
    
    
    
}
