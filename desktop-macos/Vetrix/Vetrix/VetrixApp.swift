//
//  VetrixApp.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import SwiftUI
import VetrixCore

@main
struct VetrixApp: App {
	private var baseUrl: URL
	private var config: APIConfiguration
	@State private var api: VetrixAPI
	
	init(){
		baseUrl = URL(string: "http://127.0.0.1:3000")!
		config = APIConfiguration(baseURL: baseUrl)
		api = VetrixAPI(configuration: config)
	}
	
    var body: some Scene {
        WindowGroup {
			RootView(api: api)
        }
    }
}
