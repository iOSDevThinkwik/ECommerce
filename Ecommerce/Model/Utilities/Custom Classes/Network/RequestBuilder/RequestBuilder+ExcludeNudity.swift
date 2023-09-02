//
//  RequestBuilder+ExcludeNudity.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 10/03/23.
//

import Foundation
extension RequestBuilder {
    
    func getRequestObject(api: EXCLUDE_NUDITY_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .nudity_filter :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .bodyUrlEncoded)!
            break;
        }
        return urlRequest
    }
}
