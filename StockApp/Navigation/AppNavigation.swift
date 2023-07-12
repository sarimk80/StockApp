//
//  AppNavigation.swift
//  StockApp
//
//  Created by sarim khan on 06/07/2023.
//

import Foundation
import Combine
import SwiftUI


enum TickerViewRoute: Hashable {
    case tickerDetail(sym:String)
}

class AppNavigation : ObservableObject {
    
    @Published var tickerNavigation = NavigationPath()
    @Published var topTickerNavigation = NavigationPath()
}
