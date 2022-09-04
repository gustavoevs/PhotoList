//
//  EditView.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: ViewModel
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack {
                viewModel.currentPhoto.image
                    .resizable()
                    .scaledToFit()
                    .padding()
                Form {
                    Section ("Name of Photo") {
                        TextField("Enter name of Photo", text: $name)
                    }
                }
            }
            .navigationTitle("Photo Details")
            .toolbar {
                Button("Save") {
                    viewModel.currentPhoto.name = name
                    viewModel.addCurrentPhotoToLibrary()
                    dismiss()
                }
                .disabled(name == "")
            }
        }
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(image: Image(systemName: "plus"))
//    }
//}
