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
	
	init(service: FactServiceProtocol) {
		self.service = service
	}
	
	func getScreenState(from term: String) -> Observable<FactScreenState> {
		
		let state = service.get(term)
			.map { [unowned self] facts in
				self.mapFactsToSuccessState(facts)
			}
			.catchError { [unowned self] (error) -> Observable<FactScreenState> in
				let state = self.mapErrorToScreenState(error)
				return Observable.just(state)
		}
		
		return state
	}
	
	private func mapFactsToSuccessState(_ facts: [Fact]) -> FactScreenState {
		
		let facts = facts.map {
			FactModel(fact: $0)
		}
		
		return FactScreenState.success(facts)
	}
	
	private func mapErrorToScreenState(_ error: Error) -> FactScreenState {
		
		guard let serviceError = error as? ServiceError else {
			return .unexpectedError
		}
		
		switch serviceError {
		case let .JSONParse(error):
			return .failure()
		case let .badRequest(error):
			return .failure()
		case let .connection(error):
			return .failure()
		case .internalServer:
			return .failure()
		}
	}
}
