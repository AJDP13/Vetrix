//
//  AuthenticationManager.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public final class AuthenticationManager{
	public let accessToken: String
	public let refreshToken: String
	public let expiry: Date
	
	
	init(
		accessToken: String,
		refreshToken: String,
		expiry: Date
	){
		self.accessToken = accessToken
		self.refreshToken = refreshToken
		self.expiry = expiry
	}
}
