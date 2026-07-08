//
//  LoginView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import SwiftUI
import VetrixCore

struct LoginView: View {
	@State var loginVM: LoginViewModel
	
	init(api: VetrixAPI){
		_loginVM = State(initialValue: LoginViewModel(api: api))
	}
	
    var body: some View {
		VStack(alignment: .leading, spacing: 15){
			Spacer()
			
			TextField("Username", text: $loginVM.username)
				.textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "person.circle")))
			
			SecureField("Password", text: $loginVM.password)
				.textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "lock")))
			
			Button("Login"){
				Task{
					await loginVM.login()
				}
			}
			.disabled(!loginVM.canLogin)
			.keyboardShortcut(.defaultAction)
			
			if let error = loginVM.errorMessage{
				Text(error)
					.foregroundStyle(.red)
			}
			
			Spacer()
		}
		.padding()
    }
}

#Preview {
	let url = URL(string: "http://127.0.0.1:3000")
	let config = APIConfiguration(baseURL: url!)
	let api = VetrixAPI(configuration: config)
	LoginView(api: api)
}
