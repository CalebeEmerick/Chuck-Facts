//
//  ViewCreatable.swift
//  Exercise01
//
//  Created by Calebe Emerick on 01/02/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

protocol ViewCreatable {}

extension ViewCreatable where Self: UIView {
	
	static func makeXib() -> Self {
		
		let identifier = String(describing: Self.self)
		
		guard let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? Self else {
			
			fatalError("It was not possible create Xib with identifier: \(identifier). The '.xib' and '.swift' files must have the same name.")
		}
		
		return view
	}
}

extension UIView: ViewCreatable {}
