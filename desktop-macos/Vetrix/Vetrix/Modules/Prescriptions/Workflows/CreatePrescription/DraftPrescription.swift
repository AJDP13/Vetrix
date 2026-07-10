//
//  DraftPrescription.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import Foundation
import VetrixCore

@Observable
final class DraftPrescription{
	var pet: Pet?
	var prescribedAt: Date?
	var expiresAt: Date?
	var maxRepeats: Int?
	var repeatIntervalDays: Int?
	var prescribedBy: String?
	var prescribingPractice: String?
	var notes: String = ""
	var state: PrescriptionState = .draft
}
