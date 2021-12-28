//
//  ContentView.swift
//  MapExampleMVVM
//
//  Created by M H on 28/12/2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
	
	@StateObject var vm = VM_MapDataModel()
	
	
    var body: some View {
		if vm.isUnlocked {
				ZStack {
				Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) {location in
					MapAnnotation(coordinate: location.coordinate) {
						VStack{
							Image(systemName: "star.circle")
								.resizable()
								.foregroundColor(.red)
								.frame(width: 44, height: 44)
								.background(.white)
								.clipShape(Circle())
							
							Text(location.name)
								.fixedSize()
						} // v
						.onTapGesture {
							vm.selectedPlace = location
						}
					} // anot
				} // map
				.ignoresSafeArea()
				
				Circle()
					.fill(.blue)
					.opacity(0.3)
					.frame(width: 32, height: 32)
				
				VStack{
					Spacer()
					HStack{
						Spacer()
						
						Button(action: {
							vm.addLocation()
						}, label: {
							Image(systemName: "plus")
						}) // butt
							.padding()
							.background(.black.opacity(0.75))
							.foregroundColor(.white)
							.font(.title)
							.clipShape(Circle())
							.padding(.trailing)
					} // h
				} // v
			} // z
			.sheet(item: $vm.selectedPlace, onDismiss: nil, content: { place in
				EditView(location: place) { newLocation in
					vm.update(location: newLocation)
				} // editview
		}) // sheet
			} else {
				Button("Unlock places") {
					vm.authenticate()
				} // button
				.padding()
				.background(.blue)
				.foregroundColor(.white)
				.clipShape(Capsule())
			} // if
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
