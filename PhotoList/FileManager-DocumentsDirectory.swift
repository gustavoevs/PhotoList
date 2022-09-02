//
//  FileManager-DocumentsDirectory.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 02/09/2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
