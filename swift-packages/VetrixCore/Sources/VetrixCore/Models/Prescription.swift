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

public struct Prescription: Codable, Sendable {
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
}
