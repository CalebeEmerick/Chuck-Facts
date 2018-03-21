//
//  ChuckLoading.swift
//  ChuckFacts
//
//  Created by Calebe Emerik  | Stone on 16/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class ChuckLoading {
	
	private let loadingView: ChuckLoadingView
	
	init() {
		loadingView = ChuckLoadingView()
	}
	
	func setConstraints(to view: UIView, with size: CGFloat = 80) {
		loadingView.translatesAutoresizingMaskIntoConstraints = false
		DispatchQueue.main.async {
			view.addSubview(self.loadingView)
			self.loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
			self.loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			self.loadingView.widthAnchor.constraint(equalToConstant: size).isActive = true
			self.loadingView.heightAnchor.constraint(equalToConstant: size).isActive = true
		}
	}
	
	var isLoading: Bool {
		return loadingView.imageView.isAnimating
	}
	
	func showLoading() {
		DispatchQueue.main.async {
			self.loadingView.imageView.startAnimating()
		}
	}
	
	func hideLoading() {
		DispatchQueue.main.async {
			self.loadingView.imageView.stopAnimating()
		}
	}
}
