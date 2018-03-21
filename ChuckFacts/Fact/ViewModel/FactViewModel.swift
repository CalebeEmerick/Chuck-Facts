//
//  FactViewModel.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import RxSwift

final class FactViewModel {
	
	private let service: FactServiceProtocol
	private let settings: SettingsOpenable
	
	init(service: FactServiceProtocol, settings: SettingsOpenable) {
		self.service = service
		self.settings = settings
	}
	
	func search(for term: String) -> Observable<FactScreenState> {
		let color = Color(hexString: "#f5f5f5").color
		return getScreenState(from: term)
			.startWith(.loading(color))
	}
	
	private func mapFactsToSuccessState(_ facts: [Fact]) -> FactScreenState {
		
		let facts = facts.map {
			FactModel(fact: $0)
		}
		
		if facts.isEmpty {
			return FactScreenState.successWithEmptyResult
		}
		
		return FactScreenState.success(facts)
	}
	
	private func getScreenState(from term: String) -> Observable<FactScreenState> {
		return service.get(term)
			.map { [unowned self] facts in
				self.mapFactsToSuccessState(facts)
			}
			.catchError { [unowned self] (error) -> Observable<FactScreenState> in
				let state = self.mapErrorToScreenState(error)
				return Observable.just(state)
		}
	}
	
	private func mapErrorToScreenState(_ error: Error) -> FactScreenState {
		
		guard let serviceError = error as? ServiceError else {
			return .failure(.unknown)
		}
		
		switch serviceError {
		case .JSONParse, .internalServer:
			return .failure(.unknown)
		case let .badRequest(error):
			return FactScreenState(badRequest: error)
		case .connection:
			return .failure(.connection)
		}
	}
}
