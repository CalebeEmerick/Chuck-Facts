//
//  FactsDataSource.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class FactsDataSource: NSObject {
	
	var facts: [FactModel] = []
}

extension FactsDataSource: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return facts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell: FactCell = tableView.dequeueReusableCell(for: indexPath)
		
		let fact = facts[indexPath.row]
		
		cell.fact = fact
		
		return cell
	}
}
