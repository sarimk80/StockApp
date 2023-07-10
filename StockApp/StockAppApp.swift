//
//  StockAppApp.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import SwiftUI
import SwiftData

@main
struct StockAppApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: BestMatch.self)
        }
    }
}
