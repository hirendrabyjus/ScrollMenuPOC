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

struct StackView: View {
    
    @StateObject private var viewModel = ViewModel()
    var maxVisibleCards: Int = 3
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ZStack{
                    ForEach(viewModel.cardViewDatas) { data in
                        CardView(data: data, onRemove: {
                            if viewModel.lastCardIndex < StackView.ViewModel.datas.count{
                            viewModel.moveCards(true)
                            }
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
                HStack{
                    Button(action: {
                        viewModel.moveCards(false)
                            }) {
                                Image("previous")
                                .resizable()
                                .frame(width: 16, height: 16, alignment: .leading)
                                
                            }
                            
                    Text("Previous")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.init(hex: "#8f8f8f"))
                    
                }
                .opacity(viewModel.lastCardIndex == 1 ? 0: 1)

                Spacer()
                HStack {
                    Text("\(viewModel.lastCardIndex)\(Text("/\(String(StackView.ViewModel.datas.count))").foregroundColor(Color.init(hex: "#444444")))")
                        .font(.system(size: 14))
                        .foregroundColor(Color.init(hex: "#c7c7c7"))
                }
                .offset(x: -20, y: 0)
                    
                Spacer()
                Button("View all", action: {
                })
                    .foregroundColor(Color.init(hex: "#ffb700"))
                    .font(.system(size: 14, weight: .medium))
            }
            .padding()
        }.padding()
            .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StackView( maxVisibleCards: 3).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
