//
//  InfraStructureHandlerTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class InfraStructureHandlerTests: XCTestCase {
	
	private var handler: InfraStructureHandler!
	
	private func getResponseFor(status code: Int) -> HTTPURLResponse {
		guard
			let url = URL(string: "https://www.google.com.br"),
			let response = HTTPURLResponse(url: url, statusCode: code,
													 httpVersion: nil, headerFields: nil)
			else {
				fatalError("Não foi possível criar um HTTPURLResponse.")
		}
		return response
	}
	
	private func verify(_ response: HTTPURLResponse, equalTo expectedError: BadRequestError) {
		expect {
			try self.handler.verifySuccessStatusCode(response)
			}.to(throwError { (error: ServiceError) in
				if case let .badRequest(error) = error {
					expect(error).to(equal(expectedError))
				}
				else {
					fail("Esperava-se ser um BadRequest error.")
				}
			})
	}
	
	override func setUp() {
		super.setUp()
		
		handler = InfraStructureHandler()
	}
	
	override func tearDown() {
		handler = nil
		
		super.tearDown()
	}
	
	func test_ShouldThrow_NoResultsError_When_StatusCodeIs_422() {
		
		let response = getResponseFor(status: 422)
		
		verify(response, equalTo: .noResults)
	}
	
	func test_ShouldThrow_InvalidTermError_When_StatusCodeIs_404() {
		
		let response = getResponseFor(status: 404)
		
		verify(response, equalTo: .invalidTerm)
	}
	
	func test_shouldThrow_GenericError_When_StatusCodeIs_NotHandled() {
		
		let response = getResponseFor(status: 400)
		
		verify(response, equalTo: .other)
	}
	
	func test_shouldThrow_InternalServerError_When_StatusCodeIs_500() {
		
		let response = getResponseFor(status: 500)
		
		expect {
			try self.handler.verifySuccessStatusCode(response)
			}.to(throwError { (error: ServiceError) in
				expect(error).to(equal(ServiceError.internalServer))
			})
	}
	
	func test_shouldNotThrowError_When_ReceiveSuccessulStatusCode() {
		
		let response = getResponseFor(status: 200)
		
		expect {
			try self.handler.verifySuccessStatusCode(response)
		}.toNot(throwError())
	}
}
