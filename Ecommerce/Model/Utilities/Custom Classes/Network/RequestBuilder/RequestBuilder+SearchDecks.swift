//
//  RequestBuilder+SearchDecks.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 14/12/22.
//

import Foundation
extension RequestBuilder {
    
    func getRequestObject(api: Search_Decks_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
            
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .search_decks :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .QueryParam)!
            break;
        }
        return urlRequest
    }
}
