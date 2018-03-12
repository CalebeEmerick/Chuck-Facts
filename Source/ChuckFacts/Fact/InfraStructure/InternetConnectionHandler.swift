//
//  InternetConnectionHandler.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 09/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class InternetConnectionHandler {
	
	func verify(_ error: Error) throws {
		
		guard let urlError = error as? URLError else {
			throw ServiceError.connection(.other)
		}
		
		if urlError.code == URLError.notConnectedToInternet {
			throw ServiceError.connection(.noConnection)
		}
		else if urlError.code == URLError.timedOut {
			throw ServiceError.connection(.timeout)
		}
		else {
			throw ServiceError.connection(.other)
		}
	}
}
