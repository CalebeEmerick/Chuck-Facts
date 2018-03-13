//
//  FactViewModelTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 08/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import RxSwift
import RxTest
import XCTest

final class FactViewModelTests: XCTestCase {
    
    private var disposeBag: DisposeBag!
    private var service: FactServiceMock!
    private var viewModel: FactViewModel!
    
    private let scheduler = TestScheduler(initialClock: 0)
    private var observer: TestableObserver<FactScreenState>!
    
    private var expectedLoadingColor = Color(hexString: "f5f5f5").color
    
    private func setServiceState(for state: FactServiceMock.FactScreenStateMock = .success) {
        service = FactServiceMock(desired: state)
        viewModel = FactViewModel(service: service)
    }
    
    private func searchSomeTerm() {
        viewModel.search(for: "some term")
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
    }
    
    private func compareResult(with expectedResult: [Recorded<Event<FactScreenState>>])
        -> Bool {
            
            let gotResult = observer.events
            
            return gotResult == expectedResult
    }
    
    override func setUp() {
        super.setUp()
        
        observer = scheduler.createObserver(FactScreenState.self)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        viewModel = nil
        service = nil
        
        super.tearDown()
    }
    
    func test_InitialState_ShouldBe_Loading() {
        
        setServiceState()
        searchSomeTerm()
        
        let gotState = observer.events.first!
        let expectedState = onNext(expect: FactScreenState.loading(expectedLoadingColor))
        
        let isStateEqual = gotState == expectedState
        
        expect(isStateEqual).to(beTrue())
    }
    
    func test_State_ShouldBe_Success_With_FactsList() {
        
        setServiceState()
        searchSomeTerm()
        
        let expectedResult = [
            onNext(expect: FactScreenState.loading(expectedLoadingColor)),
            onNext(expect: FactScreenState.success(service.expectedSuccessWithFacts)),
            completed()
        ]
        
        let isPipelineEqual = compareResult(with: expectedResult)
        
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_State_ShouldBe_SuccessWithEmptyResult() {
        
        setServiceState(for: .successWithEmptyResult)
        searchSomeTerm()
        
        let expectedResult = [
            onNext(expect: FactScreenState.loading(expectedLoadingColor)),
            onNext(expect: FactScreenState.successWithEmptyResult),
            completed()
        ]
        
        let isPipelineEqual = compareResult(with: expectedResult)
        
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_State_ShouldBe_Failure_With_NoResults() {
        
        setServiceState(for: .noResultsForTerm)
        searchSomeTerm()
        
        let expectedResult = [
            onNext(expect: FactScreenState.loading(expectedLoadingColor)),
            onNext(expect: FactScreenState.failure(.noResults)),
            completed()
        ]
        
        let isPipelineEqual = compareResult(with: expectedResult)
        
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_State_ShouldBe_Failure_With_InvalidTerm() {
        
        setServiceState(for: .invalidTerm)
        searchSomeTerm()
        
        let expectedResult = [
            onNext(expect: FactScreenState.loading(expectedLoadingColor)),
            onNext(expect: FactScreenState.failure(.invalidTerm)),
            completed()
        ]
        
        let isPipelineEqual = compareResult(with: expectedResult)
        
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_State_ShouldBe_Failure_With_InternalError() {
        
        setServiceState(for: .internal)
        searchSomeTerm()
        
        let expectedResult = [
            onNext(expect: FactScreenState.loading(expectedLoadingColor)),
            onNext(expect: FactScreenState.failure(.internal)),
            completed()
        ]
        
        let isPipelineEqual = compareResult(with: expectedResult)
        
        expect(isPipelineEqual).to(beTrue())
    }
}
