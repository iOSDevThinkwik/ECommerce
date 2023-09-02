//
//  Endpoints+Auth.swift
//  NSUrlSession+RequestBuilder
//
//  Created by HEMANG SOLANKI  on 16/12/21.
//

import Foundation

enum Auth_API: String {
    case login = "auth/login"
    case deleteToken = "auth/logout"
    case dashBoard = "dashboard/statistics"
    
}

extension Endpoints {
    
    static func getRequestURL(api: Auth_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Auth_API) -> String {
        switch api {
        case .login, .deleteToken:
            return HttpMethod.POST.rawValue
        case .dashBoard:
            return HttpMethod.GET.rawValue
        }
        
    }
    
}
