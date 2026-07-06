//
//  APIError.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

public enum APIError: Error {
	case api(
		statusCode: Int,
		message: String
	)
	case invalidURL
	case invalidResponse
	
	case network(Error)
	
	case decoding(Error)
	
	case server(String)
	
	case unknown(Error)
	
	public var displayMessage: String {
		switch self {
			case .api(_, let message):
				return message

			case .network:
				return "Unable to contact the server."

			case .decoding:
				return "The server returned an unexpected response."

			default:
				return "An unexpected error occurred."
		}
	}
}
