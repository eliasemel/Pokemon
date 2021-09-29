//
//  MockPokemonService.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
import Combine

final class MockPokemonService: PokemonService {
	func pokemonList(url: URL) -> PokePublisher<ContentPage<PokemonListItem>> {
		
		Just(.init(
			count: 10,
			next: URL(string: "https://www.dummy.com")!,
			previous: nil,
			results: [
				.init(name: "Emel 1", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 2", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 3", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 4", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 5", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 6", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 7", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 8", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 9", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 10", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 11", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 12", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 13", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 14", url: URL(string: "https://www.dummy.com")!),
				.init(name: "Emel 15", url: URL(string: "https://www.dummy.com")!)
			]))
			.setFailureType(to: PokeError.self)
			.eraseToAnyPublisher()
		
	}
	
	func pokemonDetails(url: URL) -> PokePublisher<Pokemon> {
		
		
		Just(.init(name: "Emel 1", height: 178, weight: 71, imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png")!))
			.setFailureType(to: PokeError.self)
			.eraseToAnyPublisher()
		
	}
		
}

