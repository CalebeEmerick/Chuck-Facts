//
//  FactService.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 02/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire

final class FactService: FactServiceProtocol {
	
	private let baseUrl: String
	private let mapper: FactMapper
	
	init(url: String) {
		baseUrl = url
		mapper = FactMapper()
	}
	
	init() {
		baseUrl = "https://api.chucknorris.io/jokes/search?query="
		mapper = FactMapper()
	}
	
	func get(_ term: String) -> Observable<[Fact]> {
		
		let urlMaker = FactURLMaker()
		let url = urlMaker.make(from: baseUrl, with: term)
		
		let result = RxAlamofire.requestJSON(.get, url)
			.do(onNext: { (response, _) in
				let handler = InfraStructureHandler()
				try handler.verifySuccessStatusCode(response)
			})
			.map { (_, result) -> JSON in
				let handler = InfraStructureHandler()
				let json = try handler.mapResultToJSON(result)
				return json
			}
			.map({ [unowned self] json in
				try self.mapJSONToFacts(json)
			})
		
		return result
	}
	
	private func mapJSONToFacts(_ json: JSON) throws -> [Fact] {
		
		do {
			let facts = try mapper.map(json)
			return facts
		}
		catch let error {
			let parser = FactMapperErrorParser()
			throw parser.parse(error)
		}
	}
}
