//
//  ChuckLoadingView.swift
//  ChuckFacts
//
//  Created by Calebe Emerik  | Stone on 16/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class ChuckLoadingView: UIView {
	
	let imageView: UIImageView
	
	init() {
		imageView = UIImageView()
		
		super.init(frame: CGRect.zero)
		
		setImageViewConstraints()
		setupImageAnimation()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setImageViewConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		DispatchQueue.main.async {
			self.addSubview(self.imageView)
			self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
			self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
			self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
			self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		}
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
