//
//  ContentView-ViewModel.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import Foundation
import SwiftUI

@MainActor class ViewModel: ObservableObject {
    @Published var photos: [Photo]
    var currentPhoto = Photo()
    
    func createPhoto(uiImage: UIImage?) {
         currentPhoto = Photo(uiimage: uiImage)
    }
    
    func addCurrentPhotoToLibrary() {
        photos.append(currentPhoto)
        save()
    }
    
    init() {
        photos = [Photo]()
        load()
    }
    
    let savePath = FileManager.documentsDirectory
    let jsonSavePath = FileManager.documentsDirectory.appendingPathComponent("metadata")

    func load() {
        // Load JSON Metadata
        do {
            let data = try Data(contentsOf: jsonSavePath)
            photos = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            photos = []
        }
        
        // Load all images
        for item in photos {
            item.loadImageFromDocumentsDir(loadPath: savePath.appendingPathComponent(item.id.uuidString))
        }
    }
    
    func save() {
        // Save metadata as JSON
        do {
            let data = try JSONEncoder().encode(photos)
            try data.write(to: jsonSavePath, options: [.atomic,.completeFileProtection])
        } catch {
            print("Unable to save metadata.")
        }
        // Save each photo with filename "id"
        for photo in photos {
            photo.saveImageToDocumentsDir(savePath: savePath)
        }
    }
}
