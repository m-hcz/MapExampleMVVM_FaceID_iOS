//
//  VM_MapDataModel.swift
//  MapExampleMVVM
//
//  Created by M H on 28/12/2021.
//

import Foundation
import LocalAuthentication
import MapKit


@MainActor class VM_MapDataModel: ObservableObject {
	
	@Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
	
	@Published private(set) var locations: [Location]
	@Published var selectedPlace: Location?
	@Published var isUnlocked = false
	
	let savePath = FileManager.documentDirectory.appendingPathComponent("SavedPlaces")
	
	init() {
		do {
			let data = try Data(contentsOf: savePath)
			locations = try JSONDecoder().decode([Location].self, from: data)
		} catch {
			locations = []
		}
	}
	
	func save() {
		do {
			let data = try JSONEncoder().encode(locations)
			try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
		} catch {
			print("Unable to save data.")
		}
	}
	
	
	func addLocation() {
		let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
		locations.append(newLocation)
		
		save()
	} // f
	
	func update(location: Location) {
		guard let selectedPlace = selectedPlace else {return}
		
		if let index = locations.firstIndex(of: selectedPlace) {
			locations[index] = location
			
			save()
		} // if
	} // f
	
	func authenticate() {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Please authenticate yourself to unlock your places." // for touch id, for face id in targets
			
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: { succes, authError in
				if succes {
					Task{ @MainActor in
						self.isUnlocked = true
					} // task
				} else {
					// error
				} // if
			}) // eval
		} else {
			// no biometrics
		}
	} // f
	
}
