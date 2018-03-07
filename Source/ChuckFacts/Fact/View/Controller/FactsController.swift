//
//  FactsController.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Initializers -

final class FactsController: UIViewController {
	
	private let disposeBag = DisposeBag()
	private let viewModel: FactViewModel
	private let factsView: FactsView
	
	init(service: FactServiceProtocol) {
		viewModel = FactViewModel(service: service)
		factsView = FactsView.makeXib()
		factsView.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
		
		title = "Fatos"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Life Cycle -

extension FactsController {
	
	override func loadView() {
		view = factsView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
}

// MARK: - Methods -

extension FactsController {
	
	
}
