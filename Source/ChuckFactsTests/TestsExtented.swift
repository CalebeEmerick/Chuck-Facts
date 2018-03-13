//
//  TestsExtented.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 13/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import RxSwift
import RxTest

public func onNext<T>(expect element: T) -> RxTest.Recorded<RxSwift.Event<T>> {
	return next(0, element)
}

public func completed<T>(_ type: T.Type = T.self) -> RxTest.Recorded<RxSwift.Event<T>> {
	return completed(0)
}

func ==<T>(lhs: [RxTest.Recorded<RxSwift.Event<T>>],
			  rhs: [RxTest.Recorded<RxSwift.Event<T>>])
	-> Bool where T : Equatable {
		
		var isEqual = true
		
		guard lhs.count == rhs.count else { return false }
		
		for index in 0 ..< lhs.count {
			
			if !(lhs[index] == rhs[index]) {
				isEqual = false
				break
			}
		}
		
		return isEqual
}
