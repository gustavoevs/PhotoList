//
//  UserPhoto.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import Foundation
import SwiftUI

struct UserPhotoMetadata: Identifiable, Codable {
    var id = UUID()
    var name: String
    var imageId: UUID?
}

struct UserPhoto: Identifiable {
    var id = UUID()
    var uiimage: UIImage?
    var image: Image {
        get {
            guard let uiimage = uiimage else {
                return Image(systemName: "clear")
            }
            return Image(uiImage: uiimage)
        }
    }
}
