//
//  PageFactory.swift
//  Pokemon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
import UIKit

/// Represents different types of page
enum PageType {
	// Represents a list page
	case list
	// Represents a details page
	case details
}


enum PageError: Error {
	// Emitted when a expected argument is missed
	case missingArgument
}



/// Generates various pages for the app
protocol PageFactory {
	
	/// Page for differnt types
	/// - Returns: A `UIViewController` page for different type
	func page(for type: PageType, pokemon: PokemonListItem?) throws  -> UIViewController
}


extension PageFactory {
	func page(for type: PageType, pokemon: PokemonListItem? = nil) throws  -> UIViewController {
		try page(for: type, pokemon: pokemon)
	}
}
