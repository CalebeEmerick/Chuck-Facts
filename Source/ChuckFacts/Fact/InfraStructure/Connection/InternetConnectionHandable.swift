//
//  InternetConnectionHandable.swift
//  ChuckFacts
//
//  Created by Calebe Emerik  | Stone on 15/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

protocol InternetConnectionHandable: class {
	
	func verify(_ error: Error) throws
}
