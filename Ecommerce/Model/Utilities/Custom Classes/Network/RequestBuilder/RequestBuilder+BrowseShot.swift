//
//  RequestBuilder+BrowseShot.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 15/11/22.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: Browse_API, imageID:String?) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api,imageID: imageID) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .browseShot, .browseImage, .browseMoreImages :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .QueryParam)!
            break;
        }
        return urlRequest
    }
}
