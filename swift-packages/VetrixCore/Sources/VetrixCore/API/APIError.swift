//
//  APIError.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

public enum APIError: Error {
	case invalidURL
	case invalidResponse
	
	case unauthenticated
	case forbidden
	case notFound
	
	case network(Error)
	
	case decoding(Error)
	
	case server(String)
}
