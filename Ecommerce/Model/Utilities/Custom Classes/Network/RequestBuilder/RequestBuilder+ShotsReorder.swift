//
//  RequestBuilder+ShotsReorder.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 16/03/23.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: DECK_SHOTS_REORDER,deckID:String?) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api,deckID:deckID) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .Deck_shots_order :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .bodyUrlEncoded)!
            break;
        }
        return urlRequest
    }
}
