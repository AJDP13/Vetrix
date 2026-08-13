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
		@Bindable var api = loginVM.api
		
		Form{
			TextField("Username", text: $loginVM.username)
			SecureField("Password", text: $loginVM.password)
			
			
			Picker("Server", selection: $api.serverService.selectedServerID){
				ForEach(api.serverService.servers){server in
					Text(server.name)
						.tag(Optional(server.id))
				}
			}
			.onChange(of: api.serverService.selectedServerID){_, newServerId in
				guard let newServerId, let server = loginVM.api.serverService.servers.first(where:{$0.id == newServerId}) else {return}
				
				api.serverService.select(server)
				Task{
					await api.serverService.ping(server)
				}
			}
			
			Section("Server Details"){
				Text("Server URL: \(api.serverService.selectedServer?.url.absoluteString ?? "UNKNOWN")")
					.disabled(true)
				
				Text(
					"Last Successful Ping: \(api.serverService.selectedServer?.last_ping_success?.formatted(date: .abbreviated, time: .shortened) ?? "Never")"
				)

				Text(
					"Last Ping: \(api.serverService.selectedServer?.last_ping?.formatted(date: .abbreviated, time: .shortened) ?? "Never")"
				)
			}
		}
		.formStyle(.grouped)
		.padding()
		.keyboardShortcut(.defaultAction)
		
		Text(api.serverService.selectedServer?.url.absoluteString ?? "UNKNOWN URL")
		
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
		
//		VStack(alignment: .leading, spacing: 15){
//			Spacer()
//			
//			TextField("Username", text: $loginVM.username)
//				.textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "person.circle")))
//			
//			SecureField("Password", text: $loginVM.password)
//				.textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "lock")))
//			
//			Button("Login"){
//				Task{
//					await loginVM.login()
//				}
//			}
//			.disabled(!loginVM.canLogin)
//			.keyboardShortcut(.defaultAction)
//			
//			if let error = loginVM.errorMessage{
//				Text(error)
//					.foregroundStyle(.red)
//			}
//			
//			Spacer()
//		}
//		.padding()
    }
}

#Preview {
	let url = URL(string: "http://127.0.0.1:3000")
	let config = APIConfiguration(baseURL: url!)
	let api = VetrixAPI(configuration: config)
	LoginView(api: api)
}
