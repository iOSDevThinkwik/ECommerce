//
//  RequestBuilder+Profile.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 17/11/22.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: Profile_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .deleteToken:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true, parameterType: .bodyUrlEncoded)!
            break;
        case .account:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .bodyUrlEncoded)!
            break;
        case .ChangePassword:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .bodyUrlEncoded)!
            break;
        }
        return urlRequest
    }
}
