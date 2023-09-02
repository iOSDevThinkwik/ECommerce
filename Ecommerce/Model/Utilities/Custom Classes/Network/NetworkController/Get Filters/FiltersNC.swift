//
//  FiltersNC.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/11/22.
//

import Foundation
import UIKit

class FiltersNC: BaseNetworkController {
    //MARK: - Filter
    
    func getFilters(completion: ((GetFiltersResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .filterAPI) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var getFiltersResponse: GetFiltersResponse?
                if let data = data
                {
                    getFiltersResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if getFiltersResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(getFiltersResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(getFiltersResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(getFiltersResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func getFiltersCount(filterDic: [String: Any]?, filterCountRequest: FilterCountRequest, completion: ((FilterCountResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .filterCount) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj = requestObj.appendQueryParams(queryPrams: filterCountRequest)!
            if filterDic != nil {
                requestObj = requestObj.appendQueryParams(queryPrams: filterDic!)!
            }
            requestObj.url = URL.init(string: (requestObj.url?.absoluteString.replace(target: "%26", withString: "&").replace(target: "%3D", withString: "="))!)

            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var filterCountResponse: FilterCountResponse?
                if let data = data
                {
                    filterCountResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if filterCountResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(filterCountResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(filterCountResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(filterCountResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: - Nudity Filter
    
    func setNudityFilter(exludeNudityRequest :ExludeNudityRequest,completion: ((NudityFilterResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .nudity_filter) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(exludeNudityRequest)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var nudityFilterResponse: NudityFilterResponse?
                if let data = data
                {
                    nudityFilterResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if nudityFilterResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(nudityFilterResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(nudityFilterResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(nudityFilterResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
}
