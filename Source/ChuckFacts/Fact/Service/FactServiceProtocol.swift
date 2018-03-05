//
//  FactServiceProtocol.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 02/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import RxSwift

protocol FactServiceProtocol: class {
	
	func get(_ term: String) -> Observable<[Fact]>
}
