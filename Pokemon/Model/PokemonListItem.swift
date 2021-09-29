//
//  PokemonListItem.swift
//  Pokimon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
struct PokemonListItem: Decodable {
	let name: String
	let url: URL
}


extension PokemonListItem: CustomStringConvertible {
	var description: String {
		"pokemon url :: \(url.absoluteURL)"
	}
}
