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
	@IBOutlet private var imageView: UIImageView!
	
	private let dataSource = FactsDataSource()
	private let delegate = FactsDelegate()
	private let disposeBag = DisposeBag()
	
	private var internalError: InternalErrorView?
	private var connectionError: ConnectionErrorView?
	
	weak var viewModel: FactViewModel?
}

// MARK: - Life Cycle -

extension FactsView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		setKeyboardButtonSubscription()
		setupImageAnimation()
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
	
	private func setupImageAnimation() {
		let images = getAnimatedImages()
		imageView.animationImages = images
		imageView.animationDuration = 2
	}
	
	private func getAnimatedImages() -> [UIImage] {
		var images: [UIImage] = []
		for index in 1 ... 22 {
			if let image = UIImage(named: "chuck-\(index)") {
				images.append(image)
			}
		}
		return images
	}
}

// MARK: - Render Methods -

extension FactsView {
	
	private func render(_ state: FactScreenState) {
		switch state {
		case let .loading(color):
			showLoading(with: color)
		case let .success(facts):
			hideConnectionError()
			prepareUIForSuccessResult()
			reloadData(with: facts)
		case .successWithEmptyResult:
			break
		case let .failure(error):
			
			switch error {
			case .connection:
				showConnectionError()
			case .internal:
				showInternalError()
			default:
				break
			}
		}
	}
	
	private func searchTerm() {
		guard let term = textField.text else { return }
		setScreenState(for: term)
	}
	
	private func showLoading(with color: UIColor) {
		setTextFieldInteration(to: false)
		setTextFieldBackground(to: color)
		showLoading()
	}
	
	private func prepareUIForSuccessResult() {
		setTableViewAlpha(to: 1)
		hideLoading()
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
	
	private func showLoading() {
		DispatchQueue.main.async {
			self.imageView.startAnimating()
		}
	}
	
	private func hideLoading() {
		DispatchQueue.main.async {
			self.imageView.stopAnimating()
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
		textField.text = ""
		setTextFieldAlpha(to: 1)
	}
	
	private func openKeyboard() {
		DispatchQueue.main.async {
			self.textField.becomeFirstResponder()
		}
	}
}

// MARK: - Error Methods -

extension FactsView {
	
	private func showInternalError() {
		prepareInternalErrorView()
		prepareToShowError()
		internalError?.showAnimated()
	}
	
	private func showConnectionError() {
		prepareConnectionErrorView()
		prepareToShowError()
		connectionError?.showAnimated()
	}
	
	private func prepareToShowError() {
		hideLoading()
		setTextFieldAlpha(to: 0)
		resetTextFieldUI()
	}
	
	private func prepareInternalErrorView() {
		let errorView = InternalErrorView.makeXib()
		errorView.setup(for: self)
		internalError = errorView
	}
	
	private func prepareConnectionErrorView() {
		let errorView = ConnectionErrorView.makeXib()
		errorView.setup(for: self)
		connectionError = errorView
		errorView.didTapTryAgain = { [weak self] in
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
}
