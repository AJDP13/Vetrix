//
//  OutlinedTextFieldStyle.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import SwiftUI
import Foundation

struct OutlinedTextFieldStyle: TextFieldStyle {
	let icon: Image?
	
	func _body(configuration: TextField<Self._Label>) -> some View{
		HStack{
			icon?.foregroundStyle(.gray)
			configuration
				.textFieldStyle(.plain)
		}
		.padding()
		.overlay{
			RoundedRectangle(cornerRadius: 8)
				.stroke(.gray, lineWidth: 2)
		}
	}
}
