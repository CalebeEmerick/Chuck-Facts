//
//  FactsView.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Initializers -

final class FactsView: UIView {
	
	@IBOutlet private var textField: UITextField!
	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var imageView: UIImageView!
	
	private let dataSource = FactsDataSource()
	private let delegate = FactsDelegate()
	private let disposeBag = DisposeBag()
	
	weak var viewModel: FactViewModel?
}

// MARK: - Life Cycle -

extension FactsView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		setupImageAnimation()
		setKeyboardButtonSubscription()
		setupTableView()
		
		
	}
}

// MARK: - Methods -

extension FactsView {
	
	func reloadData(with facts: [FactModel]) {
		DispatchQueue.main.async {
			self.dataSource.facts = facts
			self.tableView.reloadData()
		}
	}
	
	private func setupTableView() {
		tableView.register(cellNib: FactCell.self)
		tableView.estimatedRowHeight = 115
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.dataSource = dataSource
		tableView.delegate = delegate
	}
	
	private func setupImageAnimation() {
		let images = getAnimatedImages()
		imageView.animationImages = images
		imageView.animationDuration = 2
	}
	
	private func setKeyboardButtonSubscription() {
		textField.rx.controlEvent(.editingDidEndOnExit)
			.subscribe(onNext: { [unowned self] in
				
				// trava a textField
				self.textField.isUserInteractionEnabled = false
				
				// pinta o background da textField
				self.textField.backgroundColor = Color(hexString: "#ddd").color
				
				// mostra o loading
				self.imageView.startAnimating()
				
				// chama o request com o parâmetro
//				self.viewModel?
			})
			.disposed(by: disposeBag)
	}
	
	private func getAnimatedImages() -> [UIImage] {
		var images: [UIImage] = []
		for index in 1 ... 22 {
			if let image = UIImage(named: "chuck-\(index)") {
				images.append(image)
			}
		}
		return images
	}
	
	private func getScreenState() {
		viewModel?.getScreenState(from: "car")
			.subscribeOn(ConcurrentMainScheduler.instance)
			.subscribe(
				onNext: { facts in
					
					if case let .success(facts) = facts {
						self.reloadData(with: facts)
					}
			}
			)
			.disposed(by: disposeBag)
	}
}
