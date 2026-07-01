//
//  OutlinedTextFieldStyle.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import SwiftUI
import Foundation

struct OutlinedTextFieldStyle: TextFieldStyle {
	@State var icon: Image?
	
	func _body(configuration: TextField<Self._Label>) -> some View{
		HStack{
			if icon != nill{
				icon?.foregroundStyle(Color(UIColor))
			}
		}
	}
}
