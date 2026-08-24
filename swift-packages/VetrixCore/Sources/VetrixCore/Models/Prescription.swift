//
//  Prescription.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public enum PrescriptionState: String, Codable, Sendable {
	case active = "active"
	case draft = "draft"
	case void = "void"
}

public struct Prescription: Identifiable, Codable, Sendable {
	public let id: UUID
	public let pet: Pet
	public let prescribedAt: Date
	public let expiresAt: Date
	public let maxRepeats: Int
	public let repeatIntervalDays: Int
	public let prescribedBy: String
	public let prescribingPractice: String
	public let notes: String
	public let updatedAt: Date
	public let state: PrescriptionState
	
	
	public static let preview = Prescription(id: UUID(), pet: .preview, prescribedAt: Date(), expiresAt: Date(), maxRepeats: 4, repeatIntervalDays: 30, prescribedBy: "Arun", prescribingPractice: "Aspen Vets Ltd", notes: "No Notes", updatedAt: Date(), state: .active)
	
	public func withArchived(_ archived: Bool) -> Prescription {
		Prescription(
			id: id,
			pet: pet,
			prescribedAt: prescribedAt,
			expiresAt: expiresAt,
			maxRepeats: maxRepeats,
			repeatIntervalDays: repeatIntervalDays,
			prescribedBy: prescribedBy,
			prescribingPractice: prescribingPractice,
			notes: notes,
			updatedAt: updatedAt,
			state: .void
		)
	}
}
