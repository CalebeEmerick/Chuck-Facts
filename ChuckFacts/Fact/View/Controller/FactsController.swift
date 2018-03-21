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
	
	init(service: FactServiceProtocol, settings: SettingsOpenable) {
		viewModel = FactViewModel(service: service, settings: settings)
		factsView = FactsView.makeXib()
		factsView.viewModel = viewModel
		factsView.settingsOpener = settings
		
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
}
