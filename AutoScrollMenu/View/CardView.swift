//
//  CardView.swift
//  stackview
//
//  Created by Pannaga Bhushana on 15/02/22.
//

import SwiftUI

struct CardView: View, Identifiable{
    
    @State var translation: CGSize = .zero
    @StateObject private var viewModel: StackViewViewModel
    //private var onRemove: () -> ()
    var id = UUID()
    private var data =  [RevisionData]()
    private var dataCount: Int    
    init(data: RevisionData,dataCount: Int,_ viewModel : StackViewViewModel) {
        self.data.append(data)
        self.dataCount = dataCount
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                WebView(urlType: .localUrl, data: self.data)
                    .background(Color.init(hex: "#f6f6f6"))
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
            }
            /// Existing View Modifier
            
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0) // 2
            .cornerRadius(12)
            .shadow(radius: 8)
            .background(.clear)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                // 3
                DragGesture()
                // 4
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        if viewModel.getGesturePercentage(geometry, from: value) > viewModel.thresholdPercentage {
                            viewModel.moveCards(true)
                        }else{
                            self.translation = .zero
                        }
                    }
            )
            .disabled(data[0].id == dataCount - 1 ? true: false)
        }
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(data: RevisionData(mathjaxContent: "https://www.google.com", id: 0),dataCount: 0, StackViewViewModel())
//            .frame(height: 400)
//            .padding()
//    }
//}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
