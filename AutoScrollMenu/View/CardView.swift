//
//  CardView.swift
//  stackview
//
//  Created by Pannaga Bhushana on 15/02/22.
//

import SwiftUI

struct CardView: View, Identifiable{
    
    @ObservedObject var viewModel = ViewModel()
    var id = UUID()
    private var data:  Data
    
    init(data: Data) {
        self.data = data
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        VStack{
            GeometryReader { geo in
                VStack(alignment: .leading){
                    WebView(urlType: .localUrl, viewModel: viewModel)
                        .background(.white)
                        .frame(width: geo.size.width, height: geo.size.height * 0.75)
                }
                .padding(.bottom)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(data: Data(url: "https://www.google.com", id: 0))
            .frame(height: 400)
            .padding()
    }
}
