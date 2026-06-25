//
//  ContentView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import SwiftUI
import VetrixCore

struct ContentView: View {
	@State var api = VetrixAPI(configuration: APIConfiguration(baseURL: URL(string: "http://127.0.0.1:3000")!))

    var body: some View {
		if api.appSession.isAuthenticated{
			if let user = api.appSession.user{
				Text("Welcome \(user.firstName), You are now logged into the Vetrix Software")
			}
		}else{
			LoginView(api: api)
		}
    }
}

#Preview {
    ContentView()
}
