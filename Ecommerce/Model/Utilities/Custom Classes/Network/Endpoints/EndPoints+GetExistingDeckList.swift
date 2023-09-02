//
//  EndPoints+GetExistingDeckList.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 22/11/22.
//

import Foundation
enum Get_Add_To_deck_Existing_List_API: String {
    case GetAddTodeckExistingList = "decks"
}

extension Endpoints {
    
    static func getRequestURL(api: Get_Add_To_deck_Existing_List_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Get_Add_To_deck_Existing_List_API) -> String {
        switch api {
        case .GetAddTodeckExistingList :
            return HttpMethod.GET.rawValue
        }
    }
}
