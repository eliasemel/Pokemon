//
//  JsonParseHelper.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
class PokemonJsonParseHelper {
	
	/// Creates a list of pokemon from `Data`
	/// - Parameter jsonData: The json `Data`
	/// - Returns: A list of pokemon in `PokemonListItem`
	static func pokemonList(from jsonData: Data) throws -> ContentPage<PokemonListItem> {
		let contentPage: ContentPage<PokemonListItem> = try JSONDecoder().decode( ContentPage<PokemonListItem>.self, from: jsonData)
		return contentPage
	}
}
