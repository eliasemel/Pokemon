//
//  ListViewModel.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
import Combine




typealias PokemonListState = LoadState<ContentPage<PokemonListItem>>

final class ListViewModel {
	
	private(set) var service: PokemonService
	
	private var pokeListPublisher: AnyCancellable?
	
	
	@Published var state: PokemonListState = .empty
	
	
	init(service: PokemonService) {
		
		self.service = service
	}
	
	
	/// Fetch the `ContentPage` for particular URL
	/// - Parameter url: The url to fetch
	func fetchPokes(url: URL) {
		state = .loading
		
		pokeListPublisher = self.service.pokemonList(url: url)
			.receive(on: RunLoop.main)
			.sink { [weak self] completion in
				switch completion {
					case .failure(let error):
					self?.state = .failure(error)
					case .finished:
					print("Publisher is finished")
				}
			} receiveValue: { [weak self] page in
				self?.state = .loaded(page)
			}
	}
	
	
	/// Fetches the next `ContentPage`
	func nextPage() {
		
		guard case .loaded(let currentPage) = state, let next = currentPage.next else {
			return
		}
		
		fetchPokes(url: next)
		
	}

}
	
	
