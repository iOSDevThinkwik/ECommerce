//
//  RequestBuilder+WheretoStream.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 02/01/23.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: STREAMING_API,titleID:String?,countryCode:String?) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api,titleID: titleID,countryCode: countryCode) else {
            print("Unable to get request URL")
            return nil
        }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .Streaming_Options :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .JSONParam)!
            break;
        }
        return urlRequest
    }
    
}
