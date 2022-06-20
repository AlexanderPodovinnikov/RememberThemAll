//
//  MapView.swift
//  RememberThemAll
//
//  Created by Alex Po on 14.06.2022.
//

import SwiftUI
import MapKit

struct Point: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
}

struct MapView: View {
    @State private var mapRegion: MKCoordinateRegion
    let location: CLLocationCoordinate2D
    let point: Point
    @Environment(\.dismiss) var dismiss
    
    init(location: CLLocationCoordinate2D) {
        self.location = location
        self.point = Point(coordinate: location)
        _mapRegion = State(wrappedValue: MKCoordinateRegion(center: location, latitudinalMeters: 3000, longitudinalMeters: 3000))
    }
    
    var body: some View {
        GeometryReader {geo in
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: [point]) { point in
                    MapMarker(coordinate: point.coordinate)
                }
                HStack {
                    Button("< Back", action: dismiss.callAsFunction)
                        .font(.title3)
                        .padding(3)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static let location = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
    static var previews: some View {
        MapView(location: location)
    }
}
