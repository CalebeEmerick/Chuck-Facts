//
//  SettingsOpener.swift
//  ChuckFacts
//
//  Created by Calebe Emerik  | Stone on 21/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class SettingsOpener: SettingsOpenable {
	
	private let application = UIApplication.shared
	
	func open() {
		guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString),
			application.canOpenURL(settingsUrl) else {
				return
		}
		
		DispatchQueue.main.async {
			self.application.open(settingsUrl)
		}
	}
}
