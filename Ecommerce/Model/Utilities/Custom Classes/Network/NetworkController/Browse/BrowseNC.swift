//
//  BrowseNC.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 15/11/22.
//

import Foundation
import UIKit

class BrowseNC: BaseNetworkController {
    
    func BrowseShot(browseShotRequest:BrowseShotRequest?,filterDic: [String: Any]?,imageID:String? ,completion: ((BrowseResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .browseShot, imageID: imageID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj = requestObj.appendQueryParams(queryPrams: browseShotRequest)!
            if filterDic != nil {
                requestObj = requestObj.appendQueryParams(queryPrams: filterDic!)!
            }
            requestObj.url = URL.init(string: (requestObj.url?.absoluteString.replace(target: "%26", withString: "&").replace(target: "%3D", withString: "="))!)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var browseResponse: BrowseResponse?
                if let data = data
                {
                    browseResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if browseResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(browseResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(browseResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(browseResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func BrowseShotDetails(imageID:String?,completion: ((BrowseDetailResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            var imgId = imageID
            if (imgId?.components(separatedBy: ".").count)! > 1 {
                imgId = imgId?.components(separatedBy: ".").first
            }
            
            guard let requestObj = try RequestBuilder().getRequestObject(api: .browseShot,imageID: imgId) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var browseDetailResponse: BrowseDetailResponse?
                if let data = data
                {
                    browseDetailResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else if responseStatus.statusCode == 402{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(nil, responseStatus)
                        }
                    }else{
                        if browseDetailResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                if browseDetailResponse != nil {
                                    completion?(browseDetailResponse, responseStatus)
                                }else {
                                    completion?(nil, responseStatus)
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(browseDetailResponse, responseStatus)
                            }
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        //browseDetailResponse = BaseNetworkController.decodeData(data: data!)
                        if browseDetailResponse != nil{
                            completion?(browseDetailResponse, responseStatus)
                        }else{
                            completion?(nil, responseStatus)
                        }
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    func BrowseShotImage(browseShotimageRequest :BrowseShotimageRequest,imageID:String?,completion: ((Data?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .browseImage,imageID: imageID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj = requestObj.appendQueryParams(queryPrams: browseShotimageRequest)!
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                if let data = data
                {
                    DispatchQueue.main.async {
                        completion?(data, responseStatus)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion?(data, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func getMoreShots(imageID:String?,completion: ((GetMoreImagesResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            
            var imgId = imageID
            if (imgId?.components(separatedBy: ".").count)! > 1 {
                imgId = imgId?.components(separatedBy: ".").first
            }
            guard let requestObj = try RequestBuilder().getRequestObject(api: .browseMoreImages,imageID: imgId) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var getMoreImagesResponse: GetMoreImagesResponse?
                if let data = data
                {
                    getMoreImagesResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else if responseStatus.statusCode == 402{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                            completion?(nil, responseStatus)
                        }
                    }else{
                        if getMoreImagesResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(getMoreImagesResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(getMoreImagesResponse, responseStatus)
                            }
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion?(getMoreImagesResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
}
