//
//  NetworkOperationQueue.swift
//  Fenix
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation

class NetworkOperationQueue: BaseOperationQueue {
    
    override init() {
        super.init()
        maxConcurrentOperationCount = 1000
    }
}
