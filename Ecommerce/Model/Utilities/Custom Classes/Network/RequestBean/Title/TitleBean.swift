//
//  TitleBean.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 30/11/22.
//

import Foundation
// Title Deck

struct TitleRequest: Codable {
    
    let sort: String?
    var page,additional_shots: String?
}

struct TitleSearchRequest: Codable {
    
    let search: String?
}

struct TitleFilterCountRequest:Codable {
    let filter: String?
    let filter_value: String?
    //let search: String?
}
