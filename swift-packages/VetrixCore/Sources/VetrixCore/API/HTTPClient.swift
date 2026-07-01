//
//  HTTPClient.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

private struct EmptyRequest: Encodable {}
private struct EmptyResponse: Decodable {}

public final class HTTPClient{
	private let configuration: APIConfiguration
	private let session: URLSession
	private let appSession: SessionManager
	
	init(
		configuration: APIConfiguration,
		session: URLSession,
		appSession: SessionManager
	){
		self.configuration = configuration
		self.session = session
		self.appSession = appSession
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
		
		if let token = appSession.accessToken{
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
			
			if !(200...299).contains(response.statusCode){
				let error = try? JSON.decoder.decode(
					APIFailureResponse.self,
					from: data
				)
				
				throw APIError.api(
					statusCode: response.statusCode,
					message: error?.message ?? HTTPURLResponse.localizedString(forStatusCode:response.statusCode))
			}
			
			do{
				let decoded = try JSON.decoder.decode(
					APIResponse<Response>.self,
					from: data
				)
				
				return decoded.data
			}catch let error as DecodingError{
				throw APIError.decoding(error)
			}
		} catch let error as APIError{
			throw error
		} catch let error as URLError{
			throw APIError.network(error)
		} catch {
			throw APIError.unknown(error)
		}
	}
	
	public func send<Response: Decodable>(
		method: HTTPMethod,
		path: String,
		response: Response.Type
	) async throws -> Response {
		try await send(
			method: method,
			path: path,
			body: Optional<EmptyRequest>.none,
			response: response
		)
	}
	
	public func send(
		method: HTTPMethod,
		path: String
	) async throws {
		_ = try await send(
			method: method,
			path: path,
			response: EmptyResponse.self
		)
	}
	
	public func send<Request: Encodable>(
		method: HTTPMethod,
		path: String,
		body: Request
	) async throws {
		_ = try await send(
			method: method,
			path: path,
			body: body,
			response: EmptyResponse.self
		)
	}
}
