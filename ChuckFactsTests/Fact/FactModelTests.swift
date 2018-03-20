//
//  FactModelTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class FactModelTests: XCTestCase {
	
	private var factWithCategory: Fact {
		return Fact(id: "123", message: "lorem ipsum dolor sit amet",
						category: FactCategory(categories: ["Money"]))
	}
	
	private var factWithoutCategory: Fact {
		return Fact(id: "321", message: "mussum ipsum", category: nil)
	}
	
	private var bigMessageFact: Fact {
		return Fact(id: "123",
						message: "lorem ipsum dolor sit amet... asdasds asdad a sdasds asd asdasd asdasdasddsdsdsasd asd asd as as",
						category: nil)
	}
	
	private var shortMessageFact: Fact {
		return Fact(id: "123",
						message: "lorem ipsum dolor sit amet",
						category: nil)
	}
	
	func test_category_shouldBe_In_Uppercase() {
		
		let model = FactModel(fact: factWithCategory)
		
		let isUppercase = model.category == model.category.uppercased()
		
		expect(isUppercase).to(beTrue())
	}
	
	func test_factModelCategory_ShouldBe_Equal_TheCategoryUsedToCreateTheFact() {
		
		let model = FactModel(fact: factWithCategory)
		
		expect(model.category)
			.to(equal(factWithCategory.category?.categories.first?.uppercased()))
	}
	
	func test_categoryBackground_ShouldBe_Blue_When_CategoryIsNotNil() {
		
		let model = FactModel(fact: factWithCategory)
		
		expect(model.categoryBackground).to(equal(Color(hexString: "#2475b0").color))
	}
	
	func test_factModelCategory_ShouldBe_NA_When_CategoryIsNil() {
		
		let model = FactModel(fact: factWithoutCategory)
		
		expect(model.category).to(equal("N/A"))
	}
	
	func test_categoryBackground_ShouldBe_LightGray_When_CategoryIsNotNil() {
		
		let model = FactModel(fact: factWithoutCategory)
		
		expect(model.categoryBackground).to(equal(UIColor.lightGray))
	}
	
	func test_messageFont_ShouldHave_Size_Equal_14_When_MessageHasMoreThan_50_Characters() {
		
		let model = FactModel(fact: bigMessageFact)
		
		expect(model.messageFont.pointSize).to(equal(14))
	}
	
	func test_messageFont_ShouldHave_Size_Equal_16_When_MessageHasLessThan_50_Characters() {
		
		let model = FactModel(fact: shortMessageFact)
		
		expect(model.messageFont.pointSize).to(equal(16))
	}
}
