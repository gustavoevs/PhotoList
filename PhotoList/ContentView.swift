//
//  ContentView.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 01/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var showingImageEditView = false
    
    @State private var inputImage: UIImage?
    
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
                ForEach(viewModel.photos) { photo in
                    NavigationLink (destination: DetailView(photo: photo)) {
                        HStack {
                            photo.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
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
