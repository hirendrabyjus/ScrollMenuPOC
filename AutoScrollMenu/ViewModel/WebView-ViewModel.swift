//
//  CardView-ViewModel.swift
//  stackview
//
//  Created by Pannaga Bhushana on 23/02/22.
//

import Foundation
import Combine
import UIKit
import SwiftUI



class ViewModel: ObservableObject {
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
    var thresholdPercentage: CGFloat = 0.5
    
    func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
            abs(gesture.translation.width / geometry.size.width)
                
    }
}

enum WebViewNavigation {
    case backward, forward
}

enum WebUrl {
    case localUrl, publicUrl
}

