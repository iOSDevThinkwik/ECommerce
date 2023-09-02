//
//  ForgotPasswordNC.swift
//  Fenix
//
//  Created by shotDeck_developer  on 31/12/21.
//

import Foundation

class ForgotPasswordNC: BaseNetworkController {
    func forgotPassword(forgotPasswordRequest: ForgotPasswordRequest, completion: ((ForgotPasswordResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestUrl = try RequestBuilder().getRequestObject(api: .forgotpassword) else {
                let errorMsg = "Unable to build request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestUrl.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(forgotPasswordRequest)
            
            return addOperation(request: requestUrl, jsonPath: .login) {
                data, urlResponse, status in
                var forgotPasswordResponse: ForgotPasswordResponse?
                if let data = data
                {
                    forgotPasswordResponse = BaseNetworkController.decodeData(data: data)
                    if forgotPasswordResponse?.success  == false {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(forgotPasswordResponse, status)
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion?(forgotPasswordResponse, status)
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(forgotPasswordResponse, status)
                    }
                }
            }
        }
        catch {
            return nil
        }
    }
    
}
