//
//  PokemonService.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
import Combine

enum PokeError: Error {
	case apiError(Error)
	case other
}

typealias PokePublisher<T>  =  AnyPublisher<T, PokeError>

protocol PokemonService {
	
	/// Fetch a page of Pokemons
	/// - Returns: Return a page of Pokemons represented by `ContentPage<PokemonListItem>`
	func pokemonList(url: URL) -> PokePublisher<ContentPage<PokemonListItem>>
	
	
	/// Fetches details of Pokemon
	/// - Returns: Returns a `PokePublisher<Pokemon>
	func pokemonDetails(url: URL) ->  PokePublisher<Pokemon>
}
