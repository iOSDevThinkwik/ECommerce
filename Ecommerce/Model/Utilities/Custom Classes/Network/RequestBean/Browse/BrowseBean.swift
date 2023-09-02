//
//  BrowseBean.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 15/11/22.
//

import Foundation

// Browse shot

struct BrowseShotRequest: Codable {
    var page,sort,search: String?
}

struct BrowseShotimageRequest:Codable{
    let size: String
}

// MARK: - Search Request
struct SearchRequest:Codable{
    let term: String?
}

struct FilterCountRequest:Codable {
    let filter: String?
    let filter_value: String?
    let search: String?
}

struct ExludeNudityRequest: Codable {
    let exclude_nudity: Bool
}
