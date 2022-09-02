//
//  UserPhoto.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import Foundation
import SwiftUI

struct UserPhotoMetadata: Identifiable {
    var id = UUID()
    var name: String
    var imageId: UUID?
}

struct UserPhoto: Identifiable {
    var id = UUID()
    var image: Image
}
