//
//  TLReachability.swift
//  ThinkandLearn
//
//  Created by Leslie on 17/02/21.
//  Copyright © 2021 Think & Learn Pvt Ltd. All rights reserved.
//

class TLReachabilityHelper {
    static let shared = TLReachabilityHelper()
    let reachability = Reachability()
    
    private init() {}
}
