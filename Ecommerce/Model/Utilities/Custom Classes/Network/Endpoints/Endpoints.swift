//
//  Endpoints.swift
//  NSUrlSession+RequestBuilder
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case NONE
}
enum HttpStatusCode: Int
{
    case CODE_200   = 200 //success
    
    case CODE_400   = 400 // bad request
    case CODE_401   = 401 // unauthorized
    case CODE_403   = 403 // Forbidden
    case CODE_404   = 404 // Not found
    case CODE_500   = 500 // Internal server error
    
}
class Endpoints {
    
//    internal static func getBaseAppURL() -> String
//    {
//        switch ApplicationEnvironment.current {
//        case .developement:
//            return "https://stage.shotdeck.com/api/" //"https://api.shotdeck.com/api/"
//        case .staging:
//            return "https://stage.shotdeck.com/api/" //"https://api.shotdeck.com/api/"
//        case .debug:
//            return "https://stage.shotdeck.com/api/" //
//        case .production:
//            return  "https://shotdeck.com/api/" //"https://api.shotdeck.com/api/"  //"https://shotdeck.com/api/"
//        }
//    }
    
    
    internal static func getBaseAppURL() -> String
    {
        switch ApplicationEnvironment.current {
        case .developement:
            return "https://api.shotdeck.com/api/" //"https://api.shotdeck.com/api/"
        case .staging:
            return "https://api.shotdeck.com/api/" //"https://api.shotdeck.com/api/"
        case .debug:
            return "https://api.shotdeck.com/api/" //
        case .production:
            return  "https://shotdeck.com/api/" //"https://api.shotdeck.com/api/"  //"https://shotdeck.com/api/"
        }
    }
    
    
//    static func getWebURL() -> String
//    {
//        switch ApplicationEnvironment.current {
//        case .developement:
//            return "https://stage.shotdeck.com" // "https://api.shotdeck.com"
//        case .staging:
//            return "https://stage.shotdeck.com" // "https://api.shotdeck.com"
//        case .debug:
//            return "https://stage.shotdeck.com" // "https://api.shotdeck.com"
//        case .production:
//            return "https://shotdeck.com" //
//        }
//    }
//
    
    static func getWebURL() -> String
    {
        switch ApplicationEnvironment.current {
        case .developement:
            return "https://api.shotdeck.com" // "https://api.shotdeck.com"
        case .staging:
            return "https://api.shotdeck.com" // "https://api.shotdeck.com"
        case .debug:
            return "https://api.shotdeck.com" // "https://api.shotdeck.com"
        case .production:
            return "https://api.shotdeck.com" //
        }
    }
    
    static func shareWebURL() -> String{
        switch ApplicationEnvironment.current {
        case .developement:
            return "https://api.shotdeck.com/welcome/index"
        case .staging:
            return "https://api.shotdeck.com/welcome/index"
        case .debug:
            return "https://api.shotdeck.com/welcome/index"
        case .production:
            return "https://shotdeck.com"
        }
    }
    
    static func getAPIKey() -> String {
        switch ApplicationEnvironment.current {
        case .developement:
            return "k0ow84kcow80gkcgwwc4sg80gc8gw0400og04sss"
        case .staging:
            return "k0ow84kcow80gkcgwwc4sg80gc8gw0400og04sss"
        case .debug:
            return "k0ow84kcow80gkcgwwc4sg80gc8gw0400og04sss"
        case .production:
            return "k0ow84kcow80gkcgwwc4sg80gc8gw0400og04sss"
        }
    }
    
    static func getClientDeviceType() -> String {
        return "ios"
    }
    
    static func getSubscriptionURL() -> String {
        switch ApplicationEnvironment.current {
        case .developement:
            return "https://api.shotdeck.com/account/subscribe"
        case .staging:
            return "https://api.shotdeck.com/account/subscribe"
        case .debug:
            return "https://api.shotdeck.com/account/subscribe"
        case .production:
            return "https://shotdeck.com/account/subscribe"
        }
    }
    
    static func getPrivacyPolicyURL() -> String {
        switch ApplicationEnvironment.current {
        case .developement:
            return "https://shotdeck.com/welcome/privacy"
        case .staging:
            return "https://shotdeck.com/welcome/privacy"
        case .debug:
            return "https://shotdeck.com/welcome/privacy"
        case .production:
            return "https://shotdeck.com/welcome/privacy"
        }
    }
    
    static func getTermsURL() -> String {
        switch ApplicationEnvironment.current {
        case .developement:
            return "https://shotdeck.com/welcome/terms"
        case .staging:
            return "https://shotdeck.com/welcome/terms"
        case .debug:
            return "https://shotdeck.com/welcome/terms"
        case .production:
            return "https://shotdeck.com/welcome/terms"
        }
    }
    
    static func getDeleteMyAccountURL() -> String {
        switch ApplicationEnvironment.current {
        case .developement:
            return "https://help.shotdeck.com/manage-your-account/how-to-delete-your-account/"
        case .staging:
            return "https://help.shotdeck.com/manage-your-account/how-to-delete-your-account/"
        case .debug:
            return "https://help.shotdeck.com/manage-your-account/how-to-delete-your-account/"
        case .production:
            return "https://help.shotdeck.com/manage-your-account/how-to-delete-your-account/"
        }
    }
    
}
