//
//  NetworkOperationQueue.swift
//  Fenix
//
//  Created by HEMANG SOLANKI  on 16/12/21.
//

import Foundation

class NetworkOperationQueue: BaseOperationQueue {
    
    override init() {
        super.init()
        maxConcurrentOperationCount = 1000
    }
}
