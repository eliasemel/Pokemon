//
//  DefaultPokemonService.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
final class DefaultPokemonService: PokemonService {
	func pokemonList(url: URL) -> PokePublisher<ContentPage<PokemonListItem>> {
		
		return URLSession.shared.dataTaskPublisher(for: url)
				.map { $0.data }
				.decode(type: ContentPage<PokemonListItem>.self, decoder: JSONDecoder())
				.mapError { self.mapAndLog(error: $0) }
				.eraseToAnyPublisher()
	}
	
	func pokemonDetails(url: URL) -> PokePublisher<Pokemon> {
		return URLSession.shared.dataTaskPublisher(for: url)
				.map { $0.data }
				.decode(type: Pokemon.self, decoder: JSONDecoder())
				.mapError { self.mapAndLog(error: $0) }
				.eraseToAnyPublisher()
	}
}

extension DefaultPokemonService {
	func mapAndLog(error: Error) -> PokeError {
		print("error : \(error)")
		return .apiError(error)
	}
}
