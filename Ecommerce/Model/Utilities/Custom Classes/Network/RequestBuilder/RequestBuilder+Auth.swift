//
//  RequestBuilder+Auth.swift
//  NSUrlSession+RequestBuilder
//
//  Created by HEMANG SOLANKI  on 16/12/21.
//

import Foundation

extension RequestBuilder {
    
    static func appendHeaders(urlRequest: URLRequest, includeAuth: Bool = false, extraHeaders: [String: String] = [String: String](), includeJSONParam: Bool = false) -> URLRequest? {
        var urlRequest = urlRequest
        
        if includeAuth {
            urlRequest.setValue("Bearer \(UserDefaults.standard.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if extraHeaders.count > 0 {
            for headerKey in extraHeaders.keys {
                urlRequest.setValue(extraHeaders[headerKey], forHTTPHeaderField: headerKey)
            }
        }
        
        if includeJSONParam {
//            let boundary = UUID().uuidString
//            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
    
    func getRequestObject(api: Auth_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .login:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeJSONParam: false)!
            break;
        case .deleteToken:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true, includeJSONParam: false)!
            break;
        case .dashBoard:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true, includeJSONParam: false)!
            break;
        }
        return urlRequest
    }
}
