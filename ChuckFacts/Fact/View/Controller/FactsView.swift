//
//  FactsView.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Initializers -

final class FactsView: UIView {
	
	@IBOutlet private var textField: UITextField!
	@IBOutlet private var tableView: UITableView!
	
	private let dataSource = FactsDataSource()
	private let delegate = FactsDelegate()
	private let disposeBag = DisposeBag()
	
	private var internalError: InternalErrorView?
	private var connectionError: ConnectionErrorView?
	private var emptyResult: FactEmptyResultView?
	private var invalidTerm: FactInvalidTermView?
	
	private lazy var loadingView: ChuckLoading = {
		return ChuckLoading()
	}()
	
	weak var viewModel: FactViewModel?
	var settingsOpener: SettingsOpenable!
}

// MARK: - Life Cycle -

extension FactsView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		tableView.accessibilityIdentifier = "FactTableView"
		
		loadingView.setConstraints(to: self)
		setKeyboardButtonSubscription()
		setupTableView()
		openKeyboard()
	}
}

// MARK: - Setup Methods -

extension FactsView {
	
	private func setKeyboardButtonSubscription() {
		textField.rx.controlEvent(.editingDidEndOnExit)
			.subscribe(onNext: { [weak self] in
				self?.searchTerm()
			})
			.disposed(by: disposeBag)
	}
	
	private func setScreenState(for term: String) {
		viewModel?.search(for: term)
			.observeOn(MainScheduler.instance)
			.subscribe(
				onNext: { [weak self] state in
					self?.render(state)
			})
			.disposed(by: disposeBag)
	}
	
	private func setupTableView() {
		tableView.register(cellNib: FactCell.self)
		tableView.estimatedRowHeight = 115
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.dataSource = dataSource
		tableView.delegate = delegate
	}
}

// MARK: - Render Methods -

extension FactsView {
	
	private func render(_ state: FactScreenState) {
		switch state {
		case let .loading(color):
			showLoadingHidingPartialView(color)
		case let .success(facts):
			prepareUIForSuccessResult()
			reloadData(with: facts)
		case .successWithEmptyResult:
			showEmptyResultView()
		case let .failure(error):
			showFailure(for: error)
		}
	}
	
	private func showFailure(for error: FactScreenErrorType) {
		switch error {
		case .connection:
			showConnectionError()
		case .unknown:
			showInternalError()
		case .invalidTerm:
			showInvalidTermError()
		case .noResults:
			showEmptyResultView()
		}
	}
	
	private func searchTerm() {
		guard let term = textField.text else { return }
		setScreenState(for: term)
	}
	
	private func showLoading(with color: UIColor) {
		setTextFieldInteration(to: false)
		setTextFieldBackground(to: color)
		loadingView.showLoading()
	}
	
	private func prepareUIForSuccessResult() {
		setTableViewAlpha(to: 1)
		loadingView.hideLoading()
		setTextFieldAlpha(to: 0)
		resetTextFieldUI()
	}
	
	private func setTextFieldInteration(to state: Bool) {
		textField.isUserInteractionEnabled = state
	}
	
	private func setTextFieldBackground(to color: UIColor) {
		UIView.animate(withDuration: 0.25) {
			self.textField.backgroundColor = color
		}
	}
	
	private func setTableViewAlpha(to alpha: CGFloat) {
		UIView.animate(withDuration: 0.25) {
			self.tableView.alpha = alpha
		}
	}
	
	private func setTextFieldAlpha(to alpha: CGFloat) {
		UIView.animate(withDuration: 0.25) {
			self.textField.alpha = alpha
		}
	}
	
	private func reloadData(with facts: [FactModel]) {
		DispatchQueue.main.async {
			self.dataSource.facts = facts
			self.tableView.reloadData()
		}
	}
  
	private func resetTextFieldUI() {
		setTextFieldBackground(to: .white)
		setTextFieldInteration(to: true)
	}
	
	private func resetTextFieldToOriginalState() {
		resetTextFieldUI()
		cleanTextField()
		setTextFieldAlpha(to: 1)
	}
	
	private func openKeyboard() {
		DispatchQueue.main.async {
			self.textField.becomeFirstResponder()
		}
	}
	
	private func cleanTextField() {
		textField.text = ""
	}
}

// MARK: - Empty Result -

extension FactsView {
	
	private var isEmptyResultShowing: Bool {
		return emptyResult != nil
	}
	
	private func showEmptyResultView() {
		prepareToShowPartialView()
		showEmptyResult()
	}
	
	private func prepareToShowPartialView() {
		loadingView.hideLoading()
		openKeyboard()
		cleanTextField()
		resetTextFieldUI()
	}
	
	private func prepareToShowEmptyResult() {
		let emptyResult = FactEmptyResultView.makeXib()
		emptyResult.setup(for: self)
		self.emptyResult = emptyResult
	}
	
	private func showEmptyResult() {
		prepareToShowEmptyResult()
		emptyResult?.showAnimated()
	}
	
	private func hideEmptyResult(and handle: @escaping () -> Void) {
		guard isEmptyResultShowing else { return }
		emptyResult?.removeAnimated { [weak self] in
			self?.emptyResult = nil
			handle()
		}
	}
	
	private func showLoadingHidingPartialView(_ color: UIColor) {
		switch partialViewShowing {
		case .emptyResult:
			hideEmptyResult { [weak self] in
				self?.showLoading(with: color)
			}
		case .invalidTerm:
			hideInvalidTerm { [weak self] in
				self?.showLoading(with: color)
			}
		case .none:
			showLoading(with: color)
		}
	}
}

// MARK: - Error Methods -

extension FactsView {
	
	private var isInvalidTermShowing: Bool {
		return invalidTerm != nil
	}
	
	private func showInternalError() {
		prepareInternalErrorView()
		prepareToShowFullScreenError()
		internalError?.showAnimated()
	}
	
	private func showConnectionError() {
		prepareConnectionErrorView()
		prepareToShowFullScreenError()
		connectionError?.showAnimated()
	}
	
	private func showInvalidTermError() {
		prepareInvalidTermView()
		prepareToShowPartialView()
		invalidTerm?.showAnimated()
	}
	
	private func prepareToShowFullScreenError() {
		loadingView.hideLoading()
		setTextFieldAlpha(to: 0)
		resetTextFieldUI()
	}
	
	private func prepareInternalErrorView() {
		let errorView = InternalErrorView.makeXib()
		errorView.setup(for: self)
		internalError = errorView
	}
	
	private func prepareInvalidTermView() {
		let invalidTerm = FactInvalidTermView.makeXib()
		invalidTerm.setup(for: self)
		invalidTerm.showAnimated()
		self.invalidTerm = invalidTerm
	}
	
	private func prepareConnectionErrorView() {
		let errorView = ConnectionErrorView.makeXib()
		errorView.settingsOpener = settingsOpener
		errorView.setup(for: self)
		connectionError = errorView
		errorView.didTapTryAgain = { [weak self] in
			self?.loadingView.hideLoading()
			self?.resetTextFieldToOriginalState()
			self?.hideConnectionError()
			self?.openKeyboard()
		}
	}
	
	private func hideConnectionError() {
		guard connectionError != nil else { return }
		connectionError?.removeAnimated { [weak self] in
			self?.connectionError = nil
		}
	}
	
	private func hideInvalidTerm(and handle: @escaping () -> Void) {
		guard isInvalidTermShowing else { return }
		invalidTerm?.removeAnimated { [weak self] in
			self?.invalidTerm = nil
			handle()
		}
	}
	
	private var partialViewShowing: PartialViewShowing {
		if invalidTerm != nil {
			return .invalidTerm
		}
		else if emptyResult != nil {
			return .emptyResult
		}
		else {
			return .none
		}
	}
	
	private enum PartialViewShowing {
		case invalidTerm
		case emptyResult
		case none
	}
}
