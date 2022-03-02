//
//  ContentView-ViewModel.swift
//  stackview
//
//  Created by Pannaga Bhushana on 17/02/22.
//

import Foundation
import SwiftUI



extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        static var datas: [Data] = [Data(url: "https://www.yahoo.com", id: 0),Data(url: "https://www.google.com", id: 1),Data(url: "https://www.youtube.com",id: 2),Data(url: "https://www.linkedin.com", id: 3),Data(url: "https://www.medium.com", id: 4),Data(url: "https://www.yahoo.com", id: 5),Data(url: "https://www.yahoo.com",id: 6),Data(url: "https://www.yahoo.com", id: 7),Data(url: "https://www.yahoo.com", id: 8),Data(url: "https://www.yahoo.com",id: 9),Data(url: "https://www.yahoo.com",id: 10)]
        
        
        @Published var lastCardIndex: Int = 1
        @Published var translation: CGSize = .zero
        var thresholdPercentage: CGFloat = 0.5
        @Published var cardViews: [CardView] = {
            var cardViews = [CardView]()
            for i in 0..<2 {
                cardViews.append(CardView(data: datas[i]))
            }
            return cardViews
        }()
        
        func isTopCard(_ cardView: CardView) -> Bool {
            guard let index = cardViews.firstIndex(where: {$0.id == cardView.id})else {
                return false
            }
            return index == 0
        }
        
        func moveCards(_ isForward: Bool) {
            
            if isForward{
                cardViews.removeFirst()
                self.lastCardIndex += 1
                let data = ContentView.ViewModel.datas[lastCardIndex % ContentView.ViewModel.datas.count]
                let card = CardView(data: data)
                cardViews.append(card)

            }else {
                cardViews.removeLast()
                self.lastCardIndex -= 1
                let data = ContentView.ViewModel.datas[(lastCardIndex - 1) % ContentView.ViewModel.datas.count]
                let card = CardView(data: data)
                cardViews.insert(card, at: 0)
            }
                        
            
        }
        
        func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
                gesture.translation.width / geometry.size.width
        }
         func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
            let offset: CGFloat = CGFloat(id * 2) * 10
            return geometry.size.width - offset
        }
        
         func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
                return  CGFloat(id) * 5
            }
        
        private var maxID: Int {
            return ContentView.ViewModel.datas.map { $0.id }.max() ?? 0
         }
        
        func rotateSingleLeft(_ chars : [Data]) -> [Data] {
            let first = chars[0]
            var arr = chars
            for i in 0..<chars.count - 1 {
                arr[i] = arr[i + 1]
            }
            arr[chars.count - 1] = first
            return arr
        }
        
        func rotateSingleRight(_ chars : [Data]) -> [Data] {
            let last = chars.last
            var arr = chars
            for i in (1..<chars.count - 1).reversed() {
                arr[i] = arr[i - 1]
            }
            arr[0] = last!
            return arr
        }
    }
}
