//
//  FileManager.swift
//  MapExampleMVVM
//
//  Created by M H on 28/12/2021.
//

import Foundation

extension FileManager {
	static var documentDirectory: URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
}
