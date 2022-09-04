//
//  DetailView.swift
//  PhotoList
//
//  Created by Gustavo Verdugo on 02/09/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @State var photo: Photo
    @State private var mapRegion: MKCoordinateRegion
    
    var body: some View {
        NavigationView {
            VStack {
                photo.image
                    .resizable()
                    .scaledToFit()
                if let location = photo.location {
                    Map(coordinateRegion: $mapRegion, annotationItems: [location]) { location in
                        MapMarker(coordinate: location.coordinate)
                    }
                }
            }
        }
        .navigationTitle(photo.name)
    }
    
    init(photo: Photo) {
        self.photo = photo
        let region = photo.location?.coordinate ?? CLLocationCoordinate2D(latitude: 50, longitude: 0) // This should return nil
        let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
        mapRegion = MKCoordinateRegion(center: region, span: span)
    }
}
//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
