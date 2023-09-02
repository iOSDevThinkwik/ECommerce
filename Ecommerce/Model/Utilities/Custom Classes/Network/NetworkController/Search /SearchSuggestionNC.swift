//
//  SearchSuggestionNC.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 09/01/23.
//

import Foundation
import UIKit


class SearchSuggestionNC: BaseNetworkController {
    
    
    func searchSuggestion(searchRequest: SearchRequest, completion: ((SearchSuggestionResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .search) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj = requestObj.appendQueryParams(queryPrams: searchRequest)!
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var searchSuggestionResponse: SearchSuggestionResponse?
                if let data = data

                {
                    searchSuggestionResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if searchSuggestionResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(searchSuggestionResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(searchSuggestionResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(searchSuggestionResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
}
