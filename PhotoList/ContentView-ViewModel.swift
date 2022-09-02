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
    
    var selectedImage: UIImage?
    @Published var selectedImageProcessed = Image(systemName: "clear")
//    {
//        get {
//            guard let selectedImage = selectedImage else {
//                return Image(systemName: "plus")
//            }
//            if let image = Image(uiImage: selectedImage) {
//                return image
//            }
//            return Image(systemName: "plus")
//        }
//    }
    func processInputImage(uiImage: UIImage?) {
        guard let uiImage = uiImage else {
            selectedImageProcessed = Image(systemName: "clear")
            return
        }
        selectedImageProcessed = Image(uiImage: uiImage)
    }
    
    func addPhoto(imageName: String, photo: Image) {
        let userPhoto = UserPhoto(image: photo)
        let userPhotoMeta = UserPhotoMetadata(name: imageName, imageId: userPhoto.id)
        photos.append(userPhoto)
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
}
