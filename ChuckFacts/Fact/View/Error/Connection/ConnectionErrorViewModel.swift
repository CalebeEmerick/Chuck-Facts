//
//  ConnectionErrorViewModel.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 12/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class ConnectionErrorViewModel {
	
	private let settings: SettingsOpenable
	
	init(settings: SettingsOpenable) {
		self.settings = settings
	}
	
	func openSettings() {
		settings.open()
	}
}
