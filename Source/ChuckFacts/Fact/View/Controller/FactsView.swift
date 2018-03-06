//
//  FactsView.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

// MARK: - Initializers -

final class FactsView: UIView {
	
	@IBOutlet private var tableView: UITableView!
	
	private let dataSource = FactsDataSource()
	private let delegate = FactsDelegate()
	
}

// MARK: - Life Cycle -

extension FactsView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
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
		tableView.dataSource = dataSource
		tableView.delegate = delegate
	}
}
