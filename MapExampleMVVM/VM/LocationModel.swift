//
//  LocationModel.swift
//  MapExampleMVVM
//
//  Created by M H on 28/12/2021.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
	var id: UUID
	var name: String
	var description: String
	var latitude: Double
	var longitude: Double
	
	var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
	
	static let example = Location(id: UUID(), name: "Palace", description: "Queen", latitude: 51.501, longitude: -0.141)
	
	static func ==(lhs: Location, rhs: Location) -> Bool {
		lhs.id == rhs.id
	}
}
