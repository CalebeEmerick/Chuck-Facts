//
//  FactURLMaker.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class FactURLMaker {
	
	func make(from baseUrl: String, with term: String) -> String {
		
		let fullURL = "\(baseUrl)\(term)"
		
		let encodedURLForQueryString = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		return encodedURLForQueryString ?? fullURL
	}
}
