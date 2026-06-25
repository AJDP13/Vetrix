//
//  APIResponse.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct APIResponse<T:Decodable>: Decodable{
	public let success: Bool
	public let data: T?
	public let message: String?
}
