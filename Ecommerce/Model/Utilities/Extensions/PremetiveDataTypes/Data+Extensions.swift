//
//  Data+Extensions.swift
//  SHOTDECK
//
//  Created by HEMANG SOLANKI on 23/11/22.
//

import Foundation

extension Data {
    func saveFile(fileName: String, fileExtension: String) -> (Bool, URL?) {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return (false, nil)
        }
        do {
            let filePath = directory.appendingPathComponent(fileName + "." + fileExtension)!
            try self.write(to: filePath)
            return (true, filePath)
        } catch {
            print(error.localizedDescription)
            return (false, nil)
        }
    }
}

class PDFFileManager {
    
    class func saveFile(data: Data, fileName: String, fileExtension: String) -> URL? {
        let filePath = data.saveFile(fileName: fileName, fileExtension: fileExtension)
        if filePath.0 == true {
            return filePath.1
        }
        else {
            return nil
        }
    }
    
    class func getFile(fileName: String, fileExtension: String) -> URL? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        let filePath = directory.appendingPathComponent(fileName + "." + fileExtension)!
        
        if FileManager.default.fileExists(atPath: filePath.absoluteString) == true {
            return filePath
        }
        else {
            return nil
        }
    }
}
