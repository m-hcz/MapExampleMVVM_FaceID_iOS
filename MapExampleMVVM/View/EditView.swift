//
//  EditView.swift
//  MapExampleMVVM
//
//  Created by M H on 28/12/2021.
//

import SwiftUI

struct EditView: View {
	
	
	@Environment(\.dismiss) var dismiss
	var location: Location
	var onSave: (Location) -> Void
	
	
	@State private var name: String
	@State private var description: String
	
	
	init(location: Location, onSave: @escaping (Location) -> Void) {
		self.location = location
		self.onSave = onSave
		
		_name = State(initialValue: location.name)
		_description = State(initialValue: location.description)
	}
	
	var body: some View {
		NavigationView{
			Form {
				Section {
					TextField("Place name", text: $name)
					TextField("Description", text: $description)
				} // sec
			} // f
			.navigationTitle("Place details")
			.toolbar(content: {
				Button("Save") {
					var newLocation = location
					newLocation.id = UUID()
					newLocation.name = name
					newLocation.description = description
					
					onSave(newLocation)
					dismiss()
				}
			})
		} // nav
	}
}

struct EditView_Previews: PreviewProvider {
	static var previews: some View {
		EditView(location: Location.example) { _ in }
	}
}
