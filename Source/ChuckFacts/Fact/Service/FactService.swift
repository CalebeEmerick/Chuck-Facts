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
	private let infraErrorHandler: InfraStructureHandler
	private let mapper: FactMapper
	
	init(url: String) {
		baseUrl = url
		mapper = FactMapper()
		infraErrorHandler = InfraStructureHandler()
	}
	
	init() {
		baseUrl = "https://api.chucknorris.io/jokes/search?query="
		mapper = FactMapper()
		infraErrorHandler = InfraStructureHandler()
	}
	
	func get(_ term: String) -> Observable<[Fact]> {
		
		let url = makeUrl(from: term)
		
		let result = RxAlamofire.requestJSON(.get, url)
			.do(onNext: { [unowned self] (response, _) in
				try self.infraErrorHandler.verifySuccessStatusCode(response)
			})
			.map({ [unowned self] (_, result) -> JSON in
				try self.mapResultToJSON(result)
			})
			.map({ [unowned self] json in
				try self.mapJSONToFacts(json)
			})
			.do(onError: { [unowned self] error in
				
			})
		
		return result
	}
	
	private func makeUrl(from term: String) -> String {
		return "\(baseUrl)\(term)"
	}
	
	private func mapJSONToFacts(_ json: JSON) throws -> [Fact] {
		
		do {
			let facts = try mapper.map(json)
			return facts
		}
		catch let error {
			let modelParseError = JSONParseError.modelParse(error.localizedDescription)
			let parseError = ServiceError.JSONParse(modelParseError)
			throw parseError
		}
	}
	
	func mapResultToJSON(_ result: Any) throws -> JSON {
		
		guard let json = result as? JSON else {
			let serviceError = ServiceError.JSONParse(.result)
			throw serviceError
		}
		
		return json
	}
}
