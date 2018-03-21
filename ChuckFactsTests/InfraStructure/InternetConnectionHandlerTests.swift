//
//  InternetConnectionHandlerTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 15/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class InternetConnectionHandlerTests: XCTestCase {
	
	private var handler: InternetConnectionHandable!
	
	private func verifyError(_ error: URLError.Code, equalTo expectedError: InternetConnectionError) {
		expect {
			try self.handler.verify(error)
			}.to(throwError(closure: { (error: ServiceError) in
				if case let .connection(noConnection) = error {
					expect(noConnection).to(equal(expectedError))
				}
				else {
					fail("Esperava-se que o erro fosse do tipo .connection")
				}
			}))
	}
	
	override func setUp() {
		super.setUp()
		
		handler = InternetConnectionHandlerMock()
	}
	
	override func tearDown() {
		handler = nil
		
		super.tearDown()
	}
	
	func test_ShouldThrow_TheSameErrorPassed_When_IsNotConnectionError() {
		
		let internalServerError = ServiceError.internalServer
		
		expect {
			try self.handler.verify(internalServerError)
			}.to(throwError(closure: { (error: ServiceError) in
				expect(error).to(equal(ServiceError.internalServer))
			}))
	}
	
	func test_ShouldThrow_ConnectionError_When_HasNoConnectionToTheInternet() {
		
		let notConnectedToInternet = URLError.notConnectedToInternet
		
		verifyError(notConnectedToInternet, equalTo: .noConnection)
	}
	
	func test_ShouldThrow_TimeOutError_When_TheRequestWasTimedOut() {
		
		let timedOut = URLError.timedOut
		
		verifyError(timedOut, equalTo: .timeout)
	}
	
	func test_ShouldThrow_OtherError_When_TheErrorWasNotHandled() {
		
		let unknown = URLError.unknown
		
		verifyError(unknown, equalTo: .other)
	}
}
