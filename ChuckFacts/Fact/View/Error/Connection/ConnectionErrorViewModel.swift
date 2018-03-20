//
//  ConnectionErrorViewModel.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 12/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class ConnectionErrorViewModel {
	
	private let application = UIApplication.shared
	
	func openSettings() {
		
		guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString),
			application.canOpenURL(settingsUrl) else {
			return
		}
		
		DispatchQueue.main.async {
			self.application.open(settingsUrl)
		}
	}
}
