//
//  RequestBuilder+DeckDetails.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: DeckDetail_API,deckID:String?) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api, deckID: deckID) else {
            print("Unable to get request URL")
            return nil
        }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .deckDetail:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true, parameterType: .QueryParam)!
            break;
        }
        return urlRequest
    }
    
}
