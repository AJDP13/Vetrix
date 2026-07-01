//
//  RootView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import SwiftUI
import VetrixCore

struct RootView: View {
	@State var api: VetrixAPI

    var body: some View {
		if !api.appSession.isAuthenticated {
			LoginView(api: api)
		}else if let user = api.appSession.user {
			MainView(api: api)
		}else{
			ProgressView("Loading Session...")
		}
    }
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	RootView(api: api)
}
