//
//  DefaultPageFactory.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
import UIKit
import SwiftUI

final class DefaultPageFactory: PageFactory {
	let pokemonService: PokemonService
	
	init(pokemonService: PokemonService) {
		self.pokemonService = pokemonService
	}
	func page(for type: PageType, pokemon: PokemonListItem?) throws -> UIViewController {
		
		switch type {
		case .list:
			let listingViewController = ListingViewController(model: .init(service: self.pokemonService))
			return listingViewController
		case .details:
			guard let selectedPokemon = pokemon else {
				throw PageError.missingArgument
			}
			return UIHostingController(rootView: DetailView(model: DetailViewModel(pokemon: selectedPokemon, service: self.pokemonService)))
		}
	}
	
}



