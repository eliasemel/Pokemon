//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
	
	private let pokemonListItem: PokemonListItem
	
	@Published var state: LoadState<Pokemon> = .loading
	
	private let service: PokemonService
	
	private var pokemonDetailsPublisher: AnyCancellable?
	
	init(pokemon: PokemonListItem, service: PokemonService) {
		self.service = service
		self.pokemonListItem = pokemon
		
		pokemonDetailsPublisher = self.service.pokemonDetails(url: pokemon.url)
			.receive(on: RunLoop.main)
			.sink { [weak self] completion in
			switch completion {
			   case .failure(let error):
			   self?.state = .failure(error)
			   case .finished:
			   print("Publisher is finished")
			}
		} receiveValue: { [weak self] pokemon in
			self?.state = .loaded(pokemon)
		}

	}
}
