//
//  ContentView.swift
//  stackview
//
//  Created by Pannaga Bhushana on 10/02/22.
//

import SwiftUI
import CoreData

struct RevisionData: Hashable,Identifiable {
    var mathjaxContent: String
    var id: Int
    var type: String?
}

struct StackView: View {
    
    @StateObject private var viewModel = ViewModel()
    var maxVisibleCards: Int = 3
    var viewAllButtonPressed: (() -> Void)?
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ZStack{
                    
                    ForEach(Array(viewModel.cardViewDatas.enumerated()),id: \.1.id) { (index,data) in
                        CardView(data: data, dataCount: StackView.ViewModel.datas.count, onRemove: {
                            if viewModel.lastCardIndex - 1 < StackView.ViewModel.datas.count{

                            viewModel.moveCards(true)
                            }
                        })
                            .zIndex(Double((viewModel.cardViewDatas.count - 1) - index))
                            .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                            .frame(width: viewModel.getCardWidth(geometry, id: index), height: 400)
                            .offset(x: viewModel.isTopCard(data) ?viewModel.translation.width : 0, y: viewModel.getCardOffset(geometry, id: index))
                    }
                }
               
            }
            Spacer()
            FooterView(viewModel: viewModel)
                .viewAllButtonPressed {
                    self.viewAllButtonPressed?()
                }
            
        
        }.padding()
            .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StackView( maxVisibleCards: 3).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
