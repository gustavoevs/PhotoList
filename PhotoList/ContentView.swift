//
//  ContentView.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var photos = [UserPhotoMetadata]()
    @State private var showingImagePicker = false
    @State private var showingImageEditView = false
    
    @State private var inputImage: UIImage?
//    @State private var image: Image?
//    @State private var selectedImage = Image(systemName: "plus")
    
    @StateObject private var viewModel = ViewModel()
    
    enum ActiveSheet: Identifiable {
        case showingImagePicker, showingImageEditView
        var id: Int {
            hashValue
        }
    }
    @State var activeSheet: ActiveSheet?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.photosMeta) { photo in
                    NavigationLink (destination: DetailView(image: viewModel.fetchPhoto(meta: photo), name: photo.name)) {
                        HStack {
                            viewModel.fetchPhoto(meta: photo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .shadow(radius: 1)
                            Spacer()
                            VStack (alignment: .trailing) {
                                Text(photo.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("PhotoList")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        activeSheet = .showingImagePicker
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $activeSheet) { item in
                switch item {
                case .showingImagePicker:
                    ImagePicker(image: $inputImage)
                case .showingImageEditView:
                    EditView(viewModel: viewModel)
                }
            }
            .onChange(of: inputImage) { _ in
                viewModel.createPhoto(uiImage: inputImage)
                activeSheet = .showingImageEditView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
