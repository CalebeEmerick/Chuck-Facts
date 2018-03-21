//
//  Color.swift
//  Exercise01
//
//  Created by Calebe Emerick on 04/02/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

struct Color {
	
	private let allowedCharacters: CharacterSet
	private let alpha: Float
	
	let stringColor: String
	
	var color: UIColor {
		return makeColor()
	}
	
	var cgColor: CGColor {
		return makeColor().cgColor
	}
	
	init(hexString: String, alpha: Float = 1) {
		self.alpha = alpha
		allowedCharacters = CharacterSet(charactersIn: "AaBbCcDdEeFf0123456789")
		stringColor = hexString.trimmingCharacters(in: allowedCharacters.inverted)
	}
}

private extension Color {
	
	private func makeColor() -> UIColor {
		
		let hex = convertToRGB()
		
		return UIColor(red: CGFloat(hex.r / 255), green: CGFloat(hex.g / 255), blue: CGFloat(hex.b / 255), alpha: CGFloat(alpha))
	}
	
	private func convertToRGB() -> (r: Float, g: Float, b: Float) {
		
		let r, g, b: UInt32
		let hexString = stringColor
		var hex: UInt32 = 0
		
		Scanner(string: hexString).scanHexInt32(&hex)
		
		switch hexString.count {
			
		case 3:
			(r, g, b) = (((hex & 0xF00) * 17) >> 8, ((hex & 0x0F0) * 17) >> 4, (hex & 0x00F) * 17)
		case 6:
			(r, g, b) = ((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, hex & 0x0000FF)
		default:
			(r, g, b) = (0, 0, 0)
			print("Color not found.")
		}
		
		return (r: Float(r), g: Float(g), b: Float(b))
	}
}
