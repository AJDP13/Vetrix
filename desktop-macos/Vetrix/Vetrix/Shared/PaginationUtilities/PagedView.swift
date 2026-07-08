//
//  PagedView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import SwiftUI


struct PagedView<Content:View>: View{
	
	@Bindable var pagination: PaginationState
	@ViewBuilder
	let content: () -> Content
	
	var body: some View{
		VStack{
			//MARK: Header and Filters
			
			//MARK: Table
			content()
			
			//MARK: Footer/PaginationControls
			HStack{
				Spacer()
				
				ControlGroup{
					Button("Prev"){
						
					}
					.disabled(!pagination.hasPreviousPage)
					
					Button("Next"){
						
					}
					.disabled(!pagination.hasNextPage)
				}
			}
		}
	}
}
