//
//  ProfileNC.swift
//  Fenix
//
//  Created by Shotdeck_developer on 07/01/22.
//

import Foundation
class ProfileNC: BaseNetworkController {
    
    func getMeProfile(completion: ((ProfileResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .account) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var profileResponse: ProfileResponse?
                if let data = data
                {
                    profileResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if profileResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(profileResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(profileResponse, responseStatus)
                            }
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion?(profileResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func deleteToken(completion: ((DeleteTokenResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .deleteToken) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var deleteTokenResponse: DeleteTokenResponse?
                if let data = data
                {
                    deleteTokenResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if deleteTokenResponse?.success  == false {
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
    
    func changePassword(changePasswordRequest: ChangePasswordRequest ,completion: ((ChangePasswordResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .ChangePassword) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(changePasswordRequest)
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var changePasswordResponse: ChangePasswordResponse?
                if let data = data
                {
                    changePasswordResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if changePasswordResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(changePasswordResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(changePasswordResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(changePasswordResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func updateAccountInfo(updateAccountRequest: UpdateAccountRequest ,completion: ((UpdateAccountInfoResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .UpdateAccount) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(updateAccountRequest)
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var updateAccountInfoResponse: UpdateAccountInfoResponse?
                if let data = data
                {
                    updateAccountInfoResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if updateAccountInfoResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(updateAccountInfoResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(updateAccountInfoResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(updateAccountInfoResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    //    func deleteAccount(completion: ((SendUserResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
    //        do {
    //            guard let requestObj = try RequestBuilder().getRequestObject(api: .deleteAccount) else {
    //                let errorMsg = "Unable to build getAppSettings request object."
    //                print(errorMsg)
    //                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
    //                return nil
    //            }
    //
    //            return addOperation(request: requestObj) {
    //                data, response, responseStatus in
    //                var sendUserResponse: SendUserResponse?
    //                if let data = data
    //                {
    //                    sendUserResponse = BaseNetworkController.decodeData(data: data)
    //                    if sendUserResponse?.code == 401 {
    //                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
    //                            Common.shared.logout()
    //                        }
    //                    }
    //                }
    //
    //                DispatchQueue.main.async {
    //                    completion?(sendUserResponse, responseStatus)
    //                }
    //            }
    //        } catch {
    //            return nil
    //        }
    //    }
    
    //    func editMyProfile(editProfileRequest: EditProfileRequest,completion: ((ProfileResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
    //        do {
    //            guard var requestObj = try RequestBuilder().getRequestObject(api: .editProfile) else {
    //                let errorMsg = "Unable to build getAppSettings request object."
    //                print(errorMsg)
    //                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
    //                return nil
    //            }
    //
    //            requestObj.httpBody = BaseNetworkController.encodeData(editProfileRequest)
    //
    //            return addOperation(request: requestObj) {
    //                data, response, responseStatus in
    //                var profileResponse: ProfileResponse?
    //                if let data = data
    //                {
    //                    profileResponse = BaseNetworkController.decodeData(data: data)
    //                    if profileResponse?.code == 401 {
    //                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
    //                            Common.shared.logout()
    //                        }
    //                    }
    //                }
    //
    //                DispatchQueue.main.async {
    //                    completion?(profileResponse, responseStatus)
    //                }
    //            }
    //        } catch {
    //            return nil
    //        }
    //    }
    //
    //
    
}
