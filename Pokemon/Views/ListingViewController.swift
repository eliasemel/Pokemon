//
//  ListingViewController.swift
//  Pokimon
//
//  Created by Emel Elias on 2021-09-28.
//

import Foundation
import UIKit
import Combine

private struct Constants {
	static let PokeCollectionViewCellReuseIdentifier = "PokeCollectionViewCellIndentifier"
	static let footerReuseIdentifier = "footerReuseIdentifier"
}

class ListingViewController: UIViewController {
	
	
	private let pokeCollectionView: UICollectionView
	
	let model: ListViewModel
	
	private var pokemons: [PokemonListItem] = []
	
	private var statePublisher: AnyCancellable?
	
	let pageFactory: PageFactory
	
	
	private let footerView = UIActivityIndicatorView(style: .large)


	
	init(model: ListViewModel) {
		
		self.model = model
		
		let layout = UICollectionViewFlowLayout()
		self.pokeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		self.pageFactory = DefaultPageFactory(pokemonService: model.service)
		
		super.init(nibName: nil, bundle: nil)
		
		
		layout.itemSize = .init(width: self.view.bounds.width, height: 60.0)
		layout.scrollDirection = .vertical
		
		
		self.pokeCollectionView.register(
			PokeCollectionViewCell.self,
			forCellWithReuseIdentifier: Constants.PokeCollectionViewCellReuseIdentifier)
		
		self.pokeCollectionView.register(
			UICollectionReusableView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: Constants.footerReuseIdentifier)
		
		layout.footerReferenceSize = CGSize(width: self.pokeCollectionView.bounds.width, height: 100)
		
		self.pokeCollectionView.dataSource = self
		self.pokeCollectionView.delegate = self
		
		statePublisher = self.model.$state
			.sink { [weak self] state in
				switch state {
				case .failure(let error):
					print("error \(error)")
					self?.footerView.stopAnimating()
				case .loaded(let page):
					self?.pokemons += page.results
					self?.pokeCollectionView.reloadData()
					self?.footerView.stopAnimating()
				case .empty:
					print("")
				case .loading:
					print("loading..")
					self?.footerView.startAnimating()
				}
		}
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureUI()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
		super.viewDidAppear(animated)
		model.fetchPokes(url: URL(string: "https://pokeapi.co/api/v2/pokemon")!)
	}
	
	private func configureUI() {

		self.view.backgroundColor = .white
		
		self.navigationItem.title = "Pokemons"
		
		self.view.autoLayoutAddSubview(childView: self.pokeCollectionView)
		self.view.addConstraintsToFill(childView: self.pokeCollectionView)
	}
}

extension ListingViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		
		if indexPath.row == pokemons.count - 1 {
			nextPage()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		do {
			let selectedPokemon = pokemons[indexPath.row]
			let detailsViewController = try pageFactory.page(for: .details, pokemon: selectedPokemon)
			self.navigationController?.pushViewController(detailsViewController, animated: true)
		} catch let error {
			print("error \(error)")
		}
		
	}
	
}

extension ListingViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pokemons.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.PokeCollectionViewCellReuseIdentifier, for: indexPath) as! PokeCollectionViewCell
		
		
		cell.setContent(pokeList: pokemons[indexPath.row])
		
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
			if kind == UICollectionView.elementKindSectionFooter {
				let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.footerReuseIdentifier, for: indexPath)
				footer.addSubview(footerView)
				footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
				return footer
			}
			return UICollectionReusableView()
		}
	
	
}



extension ListingViewController: Pagable {
	func nextPage() {
		model.nextPage()
	}
}


class PokeCollectionViewCell: UICollectionViewCell {
	
	private lazy var label: UILabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		
		self.contentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
	
		self.contentView.autoLayoutAddSubview(childView: label)
		self.contentView.positionCenter(childView: label)
		
		
		

//		let divider = UIView()
//		divider.backgroundColor = .lightGray
//
//		self.contentView.autoLayoutAddSubview(childView: divider)
//
//
//
//		self.contentView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[divider]|", options: [], metrics: nil, views: ["divider": divider]))
//
//		self.contentView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:[label1]-[divider(1)]|", options: [], metrics: nil, views: ["label1": label, "divider": divider]))

	}
	
	public func setContent(pokeList: PokemonListItem) {
		self.label.text = pokeList.name
	}

}
