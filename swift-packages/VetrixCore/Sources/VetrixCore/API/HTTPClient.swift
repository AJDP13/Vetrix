//
//  HTTPClient.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public final class HTTPClient{
	private let configuration: APIConfiguration
	private let session: URLSession
	private let authentication: AuthenticationManager
	
	init(
		configuration: APIConfiguration,
		session: URLSession,
		authentication: AuthenticationManager
	){
		self.configuration = configuration
		self.session = session
		self.authentication = authentication
	}
	
	public func send<Request: Encodable, Response: Decodable>(
		method: HTTPMethod,
		path: String,
		body: Request? = nil,
		response: Response.Type
	) async throws -> Response {
		guard let url = URL(string: path, relativeTo: configuration.baseURL) else{
			throw APIError.invalidURL
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		if let token = authentication.accessToken{
			request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		
		if let body{
			request.httpBody = try JSON.encoder.encode(body)
		}
		
		do{
			let (data, response) = try await session.data(for: request)
			
			guard let response = response as? HTTPURLResponse else{
				throw APIError.invalidResponse
			}
			
			switch response.statusCode{
				case 200...399:
					break
				
				case 401:
					throw APIError.unauthenticated
				
				case 403:
					throw APIError.forbidden
					
				case 404:
					throw APIError.notFound
				
				default:
					throw APIError.server("HTTP \(response.statusCode)")
			}
			
			do{
				let decoded = try JSON.decoder.decode(
					APIResponse<Response>.self,
					from: data
				)
				
				return decoded.data
			}catch let error as APIError{
				throw error
			} catch{
				throw APIError.network(error)
			}
		}
	}
}
