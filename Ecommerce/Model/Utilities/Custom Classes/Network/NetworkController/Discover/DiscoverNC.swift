//
//  DiscoverNC.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 28/11/22.
//

import Foundation
import UIKit

class DiscoverNC: BaseNetworkController {
    
    func discoverData(completion: ((DiscoverResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .Discover) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var discoverResponse: DiscoverResponse?
                if let data = data
                {
                    discoverResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if discoverResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(discoverResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(discoverResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(discoverResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
}
