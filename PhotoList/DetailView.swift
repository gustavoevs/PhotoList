//
//  DetailView.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 02/09/2022.
//

import SwiftUI

struct DetailView: View {
    @State var image: Image
    @State var name: String
    
    var body: some View {
        NavigationView {
            VStack {
                image
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
        }
        .navigationTitle(name)
    }
}
//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
