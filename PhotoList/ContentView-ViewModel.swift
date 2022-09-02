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
    }
    
    func fetchPhoto(meta: UserPhotoMetadata) -> Image {
        if let image = photos.first(where: { $0.id == meta.imageId })?.image {
            return image
        } else {
            return Image(systemName: "clear")
        }
    }
    
    init() {
        _photosMeta = Published(wrappedValue: [UserPhotoMetadata]())
        _photos = Published(wrappedValue: [UserPhoto]())
    }
    
    let savePath = FileManager.documentsDirectory

//    func load() {
//        do {
//            let data = try Data(contentsOf: savePath)
//            locations = try JSONDecoder().decode([Location].self, from: data)
//        } catch {
//            locations = []
//        }
//    }
    
//    func save() {
//        // Save metadata as JSON
//        // Save each photo named as imageID.jpg
//        do {
//            let data = try JSONEncoder().encode(photosMeta)
//            try data.write(to: savePath.appendingPathComponent("Metadata"), options: [.atomic,.completeFileProtection])
//        } catch {
//            print("Unable to save metadata.")
//        }
//
//        for photo in photos {
////            image = UIImage(
////            if let jpegData = yourUIImage.jpegData(compressionQuality: 0.8) {
////                try? jpegData.write(to: yourURL, options: [.atomic, .completeFileProtection])
////            }
//        }
//    }
}
