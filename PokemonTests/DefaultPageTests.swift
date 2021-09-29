//
//  DefaultPageTests.swift
//  DefaultPageTests
//
//  Created by Emel Elias on 2021-09-28.
//

import XCTest
@testable import Pokemon
import SwiftUI

class DefaultPageTests: XCTestCase {

	let defaultPageFactory = DefaultPageFactory(pokemonService: MockPokemonService())
	
	let dummyPokeMon: PokemonListItem = .init(name: "picahu", url: URL(string: "http://picachu.com")!)
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
		
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testDetailNavigationError() {
		XCTAssertThrowsError(try defaultPageFactory.page(for: .details, pokemon: nil), "Should throw exception", { error in
			XCTAssertTrue((error as? PageError) == .missingArgument, "Should throw missingArgument")
		})

	}
	
	func testDetailNavigation() {
		
		XCTAssertTrue(try! defaultPageFactory.page(for: .details, pokemon: dummyPokeMon) is UIHostingController<DetailView>)
	}
	
	func testListNavigation() {
		XCTAssertTrue(try! defaultPageFactory.page(for: .list, pokemon: dummyPokeMon) is ListingViewController)
	}

   
}
