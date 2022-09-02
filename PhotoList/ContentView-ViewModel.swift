//
//  ContentView-ViewModel.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import Foundation
import SwiftUI

@MainActor class ViewModel: ObservableObject {
    @Published var photosMeta: [UserPhotoMetadata]
    @Published var photos: [UserPhoto]
    
    var currentUserPhoto = UserPhoto()
    
    func createPhoto(uiImage: UIImage?) {
        currentUserPhoto = UserPhoto(uiimage: uiImage)
    }
    
    func addCurrentPhotoToLibrary(imageName: String) {
        let userPhotoMeta = UserPhotoMetadata(name: imageName, imageId: currentUserPhoto.id)
        photos.append(currentUserPhoto)
        photosMeta.append(userPhotoMeta)
        save()
    }
    
    func fetchPhoto(meta: UserPhotoMetadata) -> Image {
        if let image = photos.first(where: { $0.id == meta.imageId })?.image {
            return image
        } else {
            return Image(systemName: "clear")
        }
    }
    
    init() {
//        _photosMeta = Published(wrappedValue: [UserPhotoMetadata]())
//        _photos = Published(wrappedValue: [UserPhoto]())

        photosMeta = [UserPhotoMetadata]()
        photos = [UserPhoto]()
        load()
    }
    
    let savePath = FileManager.documentsDirectory
    let jsonSavePath = FileManager.documentsDirectory.appendingPathComponent("metadata")

    func load() {
        // Load JSON Metadata
        do {
            let data = try Data(contentsOf: jsonSavePath)
            photosMeta = try JSONDecoder().decode([UserPhotoMetadata].self, from: data)
        } catch {
            photosMeta = []
        }
        
        // Load all images
        for item in photosMeta {
            if let imageid = item.imageId {
                do {
                    let imageSavePath = savePath.appendingPathComponent(imageid.uuidString)
                    let data = try Data(contentsOf: imageSavePath)
                    let uiimage = UIImage(data: data)
                    let userPhoto = UserPhoto(id: imageid, uiimage: uiimage)
                    photos.append(userPhoto)
                } catch {
                    // Load fail. Write some image that signifies fail.
                    let uiimage = UIImage(systemName: "clear")
                    let userPhoto = UserPhoto(id: imageid, uiimage: uiimage)
                    photos.append(userPhoto)
                }
            }
        }
    }
    
    func save() {
        // Save metadata as JSON
        do {
            let data = try JSONEncoder().encode(photosMeta)
            try data.write(to: jsonSavePath, options: [.atomic,.completeFileProtection])
        } catch {
            print("Unable to save metadata.")
        }
        // Save each photo named as imageID
        for photo in photos {
            guard let uiimage = photo.uiimage else { continue }
            let filePath = savePath.appendingPathComponent(photo.id.uuidString)
            if let jpegData = uiimage.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: filePath, options: [.atomic, .completeFileProtection])
            }
        }
    }
}
