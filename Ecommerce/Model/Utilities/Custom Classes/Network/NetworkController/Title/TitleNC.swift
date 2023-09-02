//
//  TitleNC.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/11/22.
//

import Foundation
import UIKit

class TitleNC: BaseNetworkController {
    
    
    func title(titleRequest: TitleRequest,filterDic: [String: Any]? ,completion: ((TitleResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .TitleMain) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj = requestObj.appendQueryParams(queryPrams: titleRequest)!
            if filterDic != nil {
                requestObj = requestObj.appendQueryParams(queryPrams: filterDic!)!
            }
            requestObj.url = URL.init(string: (requestObj.url?.absoluteString.replace(target: "%26", withString: "&").replace(target: "%3D", withString: "="))!)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var titleResponse: TitleResponse?
                if let data = data
                {
                    titleResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if titleResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(titleResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(titleResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(titleResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: -  Title Detail Decks
    
    func titleDetails(titleID:String?,completion: ((GetTitleDetailResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .Title,titleID: titleID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var getTitleDetailResponse: GetTitleDetailResponse?
                if let data = data
                {
                    getTitleDetailResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if getTitleDetailResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(getTitleDetailResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(getTitleDetailResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(getTitleDetailResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: -  Where to Stream
    
    func whereToStream(titleID:String?,countryCode:String?, completion: ((WhereToStreamResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .Streaming_Options,titleID: titleID,countryCode: countryCode) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var whereToStreamResponse: WhereToStreamResponse?
                if let data = data
                {
                    whereToStreamResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if whereToStreamResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(whereToStreamResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(whereToStreamResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(whereToStreamResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    // MARKL: - Title Search API
    
    func titleSearch(titleSearchRequest: TitleSearchRequest ,completion: ((SearchTitleResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .TitleSearch) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj = requestObj.appendQueryParams(queryPrams: titleSearchRequest)!
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var searchTitleResponse: SearchTitleResponse?
                if let data = data
                {
                    searchTitleResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if searchTitleResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(searchTitleResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(searchTitleResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(searchTitleResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
}
