//
//  CardView.swift
//  stackview
//
//  Created by Pannaga Bhushana on 15/02/22.
//

import SwiftUI

struct CardView: View, Identifiable{
    
    @ObservedObject var viewModel = ViewModel()
    @State var translation: CGSize = .zero
    private var onRemove: () -> ()
    var id = UUID()
    private var data:  Data
    
    init(data: Data, onRemove: @escaping () -> Void) {
        self.data = data
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                WebView(urlType: .localUrl, viewModel: viewModel)
                    .background(.white)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                
            }
            /// Existing View Modifier
            .shadow(radius: 5)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0) // 2
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                // 3
                DragGesture()
                // 4
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        if viewModel.getGesturePercentage(geometry, from: value) > viewModel.thresholdPercentage {
                            self.onRemove()
                        }else{
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(data: Data(url: "https://www.google.com", id: 0), onRemove: {
            
        })
            .frame(height: 400)
            .padding()
    }
}
