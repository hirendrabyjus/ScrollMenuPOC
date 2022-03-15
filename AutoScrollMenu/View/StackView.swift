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
    
    @StateObject var viewModel: StackViewViewModel
    var maxVisibleCards: Int = 3
    var viewAllButtonPressed: (() -> Void)?
    @State var cardViews: [CardView] = [CardView]()
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ZStack{
                    
                    ForEach(Array(getCardViews().enumerated()),id: \.1.id) { (index,card) in
                            card
                            .zIndex(Double((viewModel.cardViewDatas.count - 1) - index))
                            .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                            .frame(width: viewModel.getCardWidth(geometry, id: index), height: 400)
                            .offset(x: 0, y: viewModel.getCardOffset(geometry, id: index))
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

extension StackView{
    
    func getCardViews() -> [CardView] {
        var cards = [CardView]()
        for data in viewModel.cardViewDatas {
            let card = CardView(data: data, dataCount: StackViewViewModel.datas.count, viewModel)
            cards.append(card)
        }
        return cards
    }
    
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StackView( viewModel: StackViewViewModel(), maxVisibleCards: 3, cardViews: [CardView]()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
