//
//  RequestBuilder+TitleSearch.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 09/01/23.
//

import Foundation
extension RequestBuilder {
    
    func getRequestObject(api: TITLE_SEARCH_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
            
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .TitleSearch :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .QueryParam)!
            break;
        }
        return urlRequest
    }
}
