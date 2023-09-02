//
//  DecksBean.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation

// Rename Deck
struct RenameDeckRequest: Codable {
    let name: String?
}

// Create NEW Deck
struct CreateNEWDeckRequest: Codable {
    let name: String?
}

// Get Add To Existing Decks List
struct GetExistingDeckListRequest: Codable{
    let imageid: String?
}

// Get Add Caption To Deck
struct addCaptionToDeckRequest: Codable{
    let caption: String?
}

// Share Deck
struct shareDeckRequest: Codable {
    let email,rights: String?
    let share_subfolders:Bool?
    
}

// Export Deck
struct ExportDeckRequest: Codable {
    let export_type: String?
    let title_flag: Bool?
    
}

// Search Deck
struct SearchDeckRequest: Codable {
    let search: String?
}

struct TrashRequest: Codable {
    let decks1: String?
    
    enum CodingKeys: String, CodingKey {
        case decks1 = "decks[0]"
    }
}

struct ArchieveRequest: Codable {
    let decks2: String?
    
    enum CodingKeys: String, CodingKey {
        case decks2 = "decks[0]"
    }
}
