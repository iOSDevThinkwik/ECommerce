//
//  LogoutNC.swift
//  Ecommerce
//
//  Created by Hemang Solanki on 02/09/23.
//

import UIKit

class LogoutNC: BaseNetworkController {

    func deleteToken(completion: ((LogoutResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .deleteToken) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var deleteTokenResponse: LogoutResponse?
                if let data = data
                {
                    deleteTokenResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if deleteTokenResponse?.statusCode != 200 {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(deleteTokenResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(deleteTokenResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(deleteTokenResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func dashBoard(completion: ((Dashboardresponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .dashBoard) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var deleteTokenResponse: Dashboardresponse?
                if let data = data
                {
                    deleteTokenResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if deleteTokenResponse?.statusCode != 200 {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(deleteTokenResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(deleteTokenResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(deleteTokenResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
}
