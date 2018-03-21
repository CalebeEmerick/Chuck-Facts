//
//  FactServiceMock.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 08/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation
import RxSwift

final class FactServiceMock: FactServiceProtocol {
	
	private var response = HTTPURLResponse()
	private var facts: [Fact] = []
	private var result: Data = Data()
	
	private var isConnectionError = false
	
	var expectedSuccessWithFacts: [FactModel] {
		return facts.map { FactModel(fact: $0) }
	}
	
	var expectedSuccessWithEmptyFacts: [FactModel] {
		return []
	}
	
	init(desired state: FactScreenStateMock = .unknown) {
		configMock(to: state)
	}
	
	func get(_ term: String) -> Observable<[Fact]> {
		
		let handler = InfraStructureHandler()
		
		return Observable.just((response, result))
			.do(onNext: { (response, data) in
				try handler.verifySuccessStatusCode(response)
			})
			.do(onError: { [unowned self] error in
				let error = self.verifyIsInternetError(error)
				let handler = InternetConnectionHandlerMock()
				try handler.verify(error)
			})
			.map({ [unowned self] (_, data) -> [Fact] in
				let json = try handler.mapDataToJSON(data)
				return try self.mapJSONToFacts(json)
			})
	}
	
	private func configMock(to state: FactScreenStateMock) {
		isConnectionError = false
		switch state {
		case .success:
			facts = someFacts
			result = mapJSONToData(someFactsInJSON)
			setResponseForStatus(code: 200)
		case .successWithEmptyResult:
			fillWithEmptyResult()
			setResponseForStatus(code: 200)
		case .noResultsForTerm:
			setResponseForStatus(code: 422)
		case .invalidTerm:
			setResponseForStatus(code: 404)
		case .noConnection:
			isConnectionError = true
		case .unknown:
			setResponseForStatus(code: 500)
		}
	}
	
	private func mapJSONToFacts(_ json: JSON) throws -> [Fact] {
		do {
			let mapper = FactMapper()
			let facts = try mapper.map(json)
			return facts
		}
		catch let error {
			let parser = FactMapperErrorParser()
			throw parser.parse(error)
		}
	}
	
	private var someFacts: [Fact] {
		return [
			Fact(id: "tng5xzi5t9syvqaubukycw",
				  message: "Chuck Norris always knows the EXACT location of Carmen SanDiego.",
				  category: nil),
			Fact(id: "DuhjnnJCQmKAeMECnYTJuA",
				  message: "Jack in the Box's do not work around Chuck Norris. They know better than to attempt to scare Chuck Norris",
				  category: FactCategory(categories: ["car"]))
		]
	}
	
	private var someFactsInJSON: JSON {
		return [
			"total": 2,
			"result": [
				[
					"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
					"id": "tng5xzi5t9syvqaubukycw",
					"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
					"value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
				],
				[
					"category": ["Car"],
					"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
					"id": "DuhjnnJCQmKAeMECnYTJuA",
					"url": "https://api.chucknorris.io/jokes/DuhjnnJCQmKAeMECnYTJuA",
					"value": "Jack in the Box's do not work around Chuck Norris. They know better than to attempt to scare Chuck Norris"
				]
			]
		]
	}
	
	private func mapJSONToData(_ json: JSON) -> Data {
		return try! JSONSerialization.data(withJSONObject: json, options: [])
	}
	
	private func setResponseForStatus(code: Int) {
		let url = URL(string: "https://www.google.com.br")!
		response = HTTPURLResponse(url: url, statusCode: code, httpVersion: nil,
											headerFields: nil)!
	}
	
	private func fillWithEmptyResult() {
		let emptyJSON: JSON = [
			"total": 0,
			"result": []
		]
		result = mapJSONToData(emptyJSON)
	}
	
	private func verifyIsInternetError(_ error: Error) -> Error {
		if self.isConnectionError {
			return URLError.notConnectedToInternet
		}
		else {
			return error
		}
	}
	
	enum FactScreenStateMock: String {
		case success
		case successWithEmptyResult
		case noResultsForTerm
		case invalidTerm
		case noConnection
		case unknown
		
		init(state: String) {
			switch state {
			case FactScreenStateMock.success.rawValue:
				self = .success
			case FactScreenStateMock.successWithEmptyResult.rawValue:
				self = .successWithEmptyResult
			case FactScreenStateMock.noResultsForTerm.rawValue:
				self = .noResultsForTerm
			case FactScreenStateMock.invalidTerm.rawValue:
				self = .invalidTerm
			case FactScreenStateMock.noConnection.rawValue:
				self = .noConnection
			case FactScreenStateMock.unknown.rawValue:
				self = .unknown
			default:
				self = .unknown
			}
		}
	}
}

extension URLError.Code: Error {}
