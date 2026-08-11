//
//  DraftPrescription.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import Foundation
import VetrixCore

@Observable
final class DraftClient {
	var firstName: String = ""
	var lastName: String = ""
	var email: String = ""
	var phone: String = ""
	
	var address1: String = ""
	var address2: String = ""
	var address3: String = ""
	var addressCity: String = ""
	var addressPostcode: String = ""
}
