//
//  DraftPet.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//
import Foundation
import VetrixCore

@Observable
final class DraftPet {
	var name: String = ""
	var owner: Client?
	var dob: Date = Date.now
}
