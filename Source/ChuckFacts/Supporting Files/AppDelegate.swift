//
//  AppDelegate.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 01/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		let screenBounds = UIScreen.main.bounds
		let window = UIWindow(frame: screenBounds)
		
		let service = FactService()
		let rootController = FactsController(service: service)
		let rootNavigation = UINavigationController(rootViewController: rootController)
		
		window.rootViewController = rootNavigation
		
		self.window = window
		window.makeKeyAndVisible()
		
		return true
	}
}
