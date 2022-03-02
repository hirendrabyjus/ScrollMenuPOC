//
//  ContentView.swift
//  stackview
//
//  Created by Pannaga Bhushana on 10/02/22.
//

import SwiftUI
import CoreData

struct Data: Hashable,CustomStringConvertible {
    var description: String {
        return url
    }
    var url: String
    var id : Int
}

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    var maxVisibleCards: Int = 3
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ZStack{
                    ForEach(viewModel.cardViews) { cardView in
                        cardView
                            .zIndex(viewModel.isTopCard(cardView) ? 1 : 0)
                            .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                            .frame(width: viewModel.getCardWidth(geometry, id: viewModel.isTopCard(cardView) ? 0 : 1), height: 400)
                            .offset(x: viewModel.isTopCard(cardView) ?viewModel.translation.width : 0, y: viewModel.getCardOffset(geometry, id: viewModel.isTopCard(cardView) ? 0 : 1))
                            .rotationEffect(Angle(degrees: viewModel.isTopCard(cardView) ?(Double(viewModel.translation.width / geometry.size.width) * 25): 0), anchor: .bottom)
                            .gesture(
                                DragGesture()
                                    .onChanged{ value in
                                        viewModel.translation = value.translation
                                    }
                                    .onEnded{ value in
                                        if abs(viewModel.getGesturePercentage(geometry, from: value)) > viewModel.thresholdPercentage {
                                            viewModel.moveCards(true)
                                            viewModel.translation = .zero
                                        } else {
                                            viewModel.translation = .zero
                                        }
                                    }
                            )
                    }
                }
                Spacer()
            }
            
            HStack{
                Button("Previous", action: {
                    viewModel.moveCards(false)
                })
                
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( maxVisibleCards: 3).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
