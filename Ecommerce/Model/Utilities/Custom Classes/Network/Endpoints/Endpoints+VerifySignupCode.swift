//
//  Endpoints+VerifySignupCode.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation
enum Verify_Signuo_Code_API: String {
    
    case signupVerify = "signup"
}

extension Endpoints {
    
    static func getRequestURL(api: Verify_Signuo_Code_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Verify_Signuo_Code_API) -> String {
        switch api {
        case.signupVerify :
            return HttpMethod.GET.rawValue
        }
    }
}
