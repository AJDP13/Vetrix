//
//  UserDetailView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import SwiftUI
import VetrixCore

struct UserDetailView: View {
	@State var vm: UserDetailViewModel
	
	init(_ userId: UUID, api: VetrixAPI){
		self._vm = State(initialValue: UserDetailViewModel(
			userId,
			api: api
		))
	}
	
	
    var body: some View {
		Group{
			if let user = vm.user{
				VStack{
					Circle()
						.fill(.blue.gradient)
						.frame(width: 88, height: 88)
						.overlay {
							Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
								.font(.largeTitle.bold())
								.foregroundStyle(.white)
						}
					
					VStack{
						Text("\(user.firstName) \(user.lastName)")
							.foregroundStyle(.black)
							.font(.title)
						
						Text("@\(user.username)")
							.foregroundStyle(.gray)
							.font(.subheadline)
						
						Text(user.email)
							.foregroundStyle(.gray)
							.font(.caption)
					}
					
					Spacer()
					
					HStack{
						List{}
						
						Spacer()
						
						List{}
					}
					.padding()
				}
			}else if vm.isLoading{
				ProgressView("Loading...")
			}else{
				Text("Error when loading the user")
			}
		}
		.task{
			await vm.reload()
		}
    }
}

#Preview {
	let baseURL = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseURL)
	let api = VetrixAPI(configuration: config)

	UserDetailView(User.preview.id, api: api)
}
