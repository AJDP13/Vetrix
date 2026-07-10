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
	var prescribedAt: Date = Date()
	var expiresAt: Date = Calendar.current.date(byAdding: .month, value: 6, to: Date())!
	var maxRepeats: Int = 0
	var repeatIntervalDays: Int = 30
	var prescribedBy: String = ""
	var prescribingPractice: String = ""
	var notes: String = ""
	var state: PrescriptionState = .active
}
