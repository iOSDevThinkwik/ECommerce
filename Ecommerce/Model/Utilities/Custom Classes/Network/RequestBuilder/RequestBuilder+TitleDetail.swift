//
//  RequestBuilder+TitleDetail.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/11/22.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: TITLE_API,titleID:String?) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api,titleID:titleID) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .Title :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .QueryParam)!
            break;
        }
    
        return urlRequest
    }
}
