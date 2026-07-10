//
//  JSON.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

enum JSON {
	static let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase

		let fractionalFormatter = ISO8601DateFormatter()
		fractionalFormatter.formatOptions = [
			.withInternetDateTime,
			.withFractionalSeconds
		]

		let standardFormatter = ISO8601DateFormatter()
		standardFormatter.formatOptions = [
			.withInternetDateTime
		]

		decoder.dateDecodingStrategy = .custom { decoder in
			let container = try decoder.singleValueContainer()
			let string = try container.decode(String.self)

			if let date = fractionalFormatter.date(from: string) {
				return date
			}

			if let date = standardFormatter.date(from: string) {
				return date
			}

			throw DecodingError.dataCorruptedError(
				in: container,
				debugDescription: "Invalid ISO8601 date: \(string)"
			)
		}

		return decoder
	}()

	static let encoder: JSONEncoder = {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		encoder.dateEncodingStrategy = .iso8601
		return encoder
	}()
}
