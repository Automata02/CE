//
//  CountryMapView.swift
//  CE
//
//  Created by automata on 18/02/2025.
//
import SwiftUI
import MapKit

struct CountryMapView: View {
    let coordinate: CLLocationCoordinate2D
    let span: MKCoordinateSpan
    let title: String
    
    init(
        latitude: Double,
        longitude: Double,
        title: String,
        spanDelta: Double = 10.0
    ) {
        self.coordinate = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        self.span = MKCoordinateSpan(
            latitudeDelta: spanDelta,
            longitudeDelta: spanDelta
        )
        self.title = title
    }
    
    var body: some View {
        Map(initialPosition: .region(MKCoordinateRegion(
            center: coordinate,
            span: span
        ))) {
            Marker(title, coordinate: coordinate)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
