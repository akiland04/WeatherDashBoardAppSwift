//
//  LocationManager.swift
//  WeatherDashboardTemplate
//
//  Created by girish lukka on 18/10/2025.
//

import Foundation
import CoreLocation
@preconcurrency import MapKit


@MainActor
final class LocationManager {
    
    func geocodeAddress(_ address: String) async throws -> (name: String, lat: Double, lon: Double) {
        let placeMarks = try await CLGeocoder()
            .geocodeAddressString(address)
        guard let location = placeMarks.first?.location else {
            throw WeatherMapError.geocodingFailed(address)
        }
    
        return (name: address, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
    
    func findPOIs(lat: Double, lon: Double, limit: Int = 5) async throws -> [AnnotationModel] {
        // Uses `MKLocalSearch` to find Points of Interest (POIs), specifically "Tourist Attractions," within a small region around the given latitude and longitude.
        // Executes the search request.
        // Maps the `MKMapItem` results into an array of `AnnotationModel`s, filtering out any without a name.
        // Limits the final array size to the specified `limit`.
        
        // DUMMY RETURN TO SATISFY COMPILER
        preconditionFailure("Stubbed function not implemented. Requires a [AnnotationModel] return.")
    }
}
