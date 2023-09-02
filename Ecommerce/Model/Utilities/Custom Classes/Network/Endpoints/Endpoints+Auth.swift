//
//  Endpoints+Auth.swift
//  NSUrlSession+RequestBuilder
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation

enum Auth_API: String {
    case login = "login"
    case signupAccount = "account"
    case signup = "signup"
    case forgotpassword = "forgot_password"
    case getJobCategory = "job_categories"
}

extension Endpoints {
    
    static func getRequestURL(api: Auth_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Auth_API) -> String {
        switch api {
        case .login, .signup , .signupAccount:
            return HttpMethod.POST.rawValue
        case .getJobCategory:
            return HttpMethod.GET.rawValue
        case .forgotpassword:
            return HttpMethod.PUT.rawValue
        }
    }
    
}
