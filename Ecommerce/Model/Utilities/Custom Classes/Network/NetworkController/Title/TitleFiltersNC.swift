//
//  TitleFiltersNC.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 10/05/23.
//

import Foundation
import UIKit

class TitleFiltersNC: BaseNetworkController {
    
    //MARK: - Filter
    
    func getTitleFilters(completion: ((GetTitleFiltersResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .title_filterAPI) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var getTitleFiltersResponse: GetTitleFiltersResponse?
                if let data = data
                {
                    getTitleFiltersResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if getTitleFiltersResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(getTitleFiltersResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(getTitleFiltersResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(getTitleFiltersResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func getTitleFiltersCount(titleFilterDic: [String: Any]?, titleFilterCountRequest: TitleFilterCountRequest, completion: ((TitleFilterCountResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .title_filterCount) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj = requestObj.appendQueryParams(queryPrams: titleFilterCountRequest)!
            if titleFilterDic != nil {
                requestObj = requestObj.appendQueryParams(queryPrams: titleFilterDic!)!
            }
            requestObj.url = URL.init(string: (requestObj.url?.absoluteString.replace(target: "%26", withString: "&").replace(target: "%3D", withString: "="))!)

            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var titleFilterCountResponse: TitleFilterCountResponse?
                if let data = data
                {
                    titleFilterCountResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if titleFilterCountResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(titleFilterCountResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(titleFilterCountResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(titleFilterCountResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
}
