//
//  FooterView.swift
//  AutoScrollMenu
//
//  Created by Pannaga Bhushana on 10/03/22.
//

import SwiftUI

extension StackView {
    
    struct FooterView: View {
        @StateObject var viewModel: StackViewViewModel
        var viewAllButtonPressed = {}

        var body: some View {
            HStack{
                HStack{
                        Button(action: {
                                    viewModel.moveCards(false)
                            }) {
                                
                                Image("app_level_extra_small_arrow_left_transparent")
                                .resizable()
                                .renderingMode(.original)
                                
                                }
                            .frame(width: 16, height: 16, alignment: .leading)
                            
                    Text("Previous")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.init(hex: "#8f8f8f"))
                    
                }
                .opacity(viewModel.lastCardIndex == 2 ? 0: 1)

                Spacer()
                HStack {
                    Text("\(viewModel.lastCardIndex - 1)\(Text("/\(String(StackViewViewModel.datas.count))").foregroundColor(Color.init(hex: "#444444")))")
                        .font(.system(size: 14))
                        .foregroundColor(Color.init(hex: "#c7c7c7"))
                }
                .offset(x: -20, y: 0)
                    
                Spacer()
                Button("View all", action: {
                    self.viewAllButtonPressed()
                })
                    .foregroundColor(Color.init(hex: "#ffb700"))
                    .font(.system(size: 14, weight: .medium))
        }
            .padding()
    }
       
        func viewAllButtonPressed(_ callback: @escaping () -> ()) -> some View {
            FooterView(viewModel: viewModel, viewAllButtonPressed: callback)
        }
    }

//    struct FooterView_Previews: PreviewProvider {
//        static var previews: some View {
//            FooterView(viewModel: StackViewViewModel())
//        }
//    }

}

