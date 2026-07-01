//
//  ErrorManager.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import Foundation

@Observable

public final class ErrorManager{
	public var error: APIError?
	
	public init() {}
	
	public func present(_ error: APIError){
		self.error = error
	}
	
	public func present(_ error: Error){
		if let apiError = error as? APIError{
			self.error = apiError
		}else{
			self.error = .unknown(error)
		}
	}
	
	public func clear(){
		error = nil
	}
}
