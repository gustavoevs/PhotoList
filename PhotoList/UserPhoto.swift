//
//  UserPhoto.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import Foundation
import SwiftUI
import CoreLocation

// NOTE: Although it would be more elegant to have the photo info and the photo itself in the same struct, I seperated them in order to have the photo info easily encodable to JSON, and keep the photos themselves in a separate struct.
// These two structs were replaced by the single class "Photo". Left in code for discussion with friends in future.
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

class Photo: Identifiable, Codable {
    var id: UUID
    var name: String = ""
    var uiimage: UIImage?
    // NOTE: I don't know what the performance impact of having Image being created every time the UI accesses this.
    var image: Image {
        get {
            guard let uiimage = uiimage else {
                return Image(systemName: "clear")
            }
            return Image(uiImage: uiimage)
        }
    }
    var location: Location?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case location
    }
    
    init() { self.id = UUID() }
    
    init(uiimage: UIImage?) {
        self.id = UUID()
        self.uiimage = uiimage
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(Location.self, forKey: .location)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
    }
    
    func saveImageToDocumentsDir(savePath: URL) {
        guard let uiimage = uiimage else {
            return
        }
        let filePath = savePath.appendingPathComponent(id.uuidString)
        if let jpegData = uiimage.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: filePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func loadImageFromDocumentsDir(loadPath: URL) {
        do {
            let imageSavePath = loadPath.appendingPathComponent(id.uuidString)
            let data = try Data(contentsOf: imageSavePath)
            uiimage = UIImage(data: data)
        } catch {
        }
    }
}
