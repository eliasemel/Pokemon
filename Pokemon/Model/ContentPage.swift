//
//  ContentPage.swift
//  Pokimon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation


/// Represents a page in response
struct ContentPage<Model: Decodable>: Decodable {
	
	let count: Int
	let next: URL?
	let previous: URL?
	let results: [Model]
}


extension ContentPage {
	
	var hasNext: Bool {
		self.next != nil
	}
}
