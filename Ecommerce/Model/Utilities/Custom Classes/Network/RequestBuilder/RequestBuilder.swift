//
//  RequestBuilder.swift
//  NSUrlSession+RequestBuilder
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation
enum ParamaterTypes {
    case bodyUrlEncoded
    case JSONParam
    case body
    case QueryParam
}
class RequestBuilder {
    
    static func appendHeaders(urlRequest: URLRequest, includeAuth: Bool = false, extraHeaders: [String: String] = [String: String](), parameterType: ParamaterTypes = .body) -> URLRequest? {
        var urlRequest = urlRequest
        
        urlRequest.setValue(Endpoints.getAPIKey(), forHTTPHeaderField: "x-api-key")
        
        if includeAuth {
            urlRequest.setValue(UserDefaults.standard.accessToken, forHTTPHeaderField: "X-AUTH-TOKEN")
        }
        
        if extraHeaders.count > 0 {
            for headerKey in extraHeaders.keys {
                urlRequest.setValue(extraHeaders[headerKey], forHTTPHeaderField: headerKey)
            }
        }
        
        switch parameterType {
        case .bodyUrlEncoded:
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            break;
        case .JSONParam:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            break;
        default:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            break;
        }
        return urlRequest
    }
}
