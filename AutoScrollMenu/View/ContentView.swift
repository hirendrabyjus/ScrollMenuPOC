//
//  ContentView.swift
//  stackview
//
//  Created by Pannaga Bhushana on 10/02/22.
//

import SwiftUI
import CoreData

struct Data: Hashable,Identifiable {
    var mathjaxContent: String
    var id: Int
}

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    var maxVisibleCards: Int = 3
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ZStack{
                    ForEach(viewModel.cardViewDatas) { data in
                        CardView(data: data, onRemove: {
                            viewModel.moveCards(true)
                        })
                            .zIndex(viewModel.isTopCard(data) ? 1 : 0)
                            .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                            .frame(width: viewModel.getCardWidth(geometry, id: viewModel.isTopCard(data) ? 0 : 1), height: 400)
                            .offset(x: viewModel.isTopCard(data) ?viewModel.translation.width : 0, y: viewModel.getCardOffset(geometry, id: viewModel.isTopCard(data) ? 0 : 1))
                            .rotationEffect(Angle(degrees: viewModel.isTopCard(data) ?(Double(viewModel.translation.width / geometry.size.width) * 25): 0), anchor: .bottom)
                    }
                }
                Spacer()
            }
            
            HStack{
                Button("Previous", action: {
                    viewModel.moveCards(false)
                })
                    .opacity(viewModel.lastCardIndex == 1 ? 0: 1)
            }
        }.padding()
            .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( maxVisibleCards: 3).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
