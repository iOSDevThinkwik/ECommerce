//
//  RequestBuilder+Titles.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 30/11/22.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: TITLE_MAIN_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .TitleMain :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .QueryParam)!
            break;
        }
    
        return urlRequest
    }
}
