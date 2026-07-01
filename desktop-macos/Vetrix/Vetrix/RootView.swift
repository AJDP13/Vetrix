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
		Group{
			if !api.appSession.isAuthenticated {
				LoginView(api: api)
			}else if let user = api.appSession.user {
				MainView(api: api)
			}else{
				ProgressView("Loading Session...")
			}
		}
		.globalErrorAlert(api: api)
    }
}

extension View {
	func globalErrorAlert(api: VetrixAPI) -> some View {
		alert(
			"Error",
			isPresented: Binding(
				get: { api.errorManager.error != nil },
				set: { if !$0 { api.errorManager.clear() } }
			)
		) {
			Button("OK") {
				api.errorManager.clear()
			}
		} message: {
			Text(api.errorManager.error?.displayMessage ?? "")
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	RootView(api: api)
}
