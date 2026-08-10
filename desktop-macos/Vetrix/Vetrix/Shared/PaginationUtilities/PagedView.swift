//
//  PagedView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import SwiftUI


struct PagedView<Content:View>: View{
	
	@Bindable var pagination: PaginationState
	let isLoading: Bool
	let next: () async -> Void
	let previous: () async -> Void
	let search: () async -> Void
	
	@ViewBuilder
	let content: () -> Content
	
	var body: some View{
		VStack{
			//MARK: Header and Filters
			
			HStack{
				TextField(
					"Search",
					text: $pagination.query
				)
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					Task{
						await search()
					}
				}
			}
			
			//MARK: Table
			Spacer()
			
			if isLoading{
				VStack{
					ProgressView()
					Text("Loading...")
				}
			}else{
				content()
			}
			
			Spacer()
			
			//MARK: Footer/PaginationControls
			HStack{
				Spacer()
				
				ControlGroup{
					Button("Prev"){
						Task{
							await previous()
						}
					}
					.disabled(!pagination.hasPreviousPage || isLoading)
					
					Button("Next"){
						Task{
							await next()
						}
					}
					.disabled(!pagination.hasNextPage || isLoading)
				}
			}
		}
	}
}
