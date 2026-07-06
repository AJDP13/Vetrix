//
//  APIConfiguration.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct APIConfiguration: Sendable{
	public let baseURL: URL
	
	public init(baseURL: URL){
		self.baseURL = baseURL
	}
	
	public static let preview = APIConfiguration(baseURL: URL(string: "http://127.0.0.1:3000")!)
}
