//
//  TopTraded.swift
//  StockApp
//
//  Created by sarim khan on 11/07/2023.
//

import Foundation

struct TopTraded: Codable {
    let metadata, lastUpdated: String
    let topGainers, topLosers, mostActivelyTraded: [MostActivelyTraded]

    enum CodingKeys: String, CodingKey {
        case metadata
        case lastUpdated = "last_updated"
        case topGainers = "top_gainers"
        case topLosers = "top_losers"
        case mostActivelyTraded = "most_actively_traded"
    }
}

struct MostActivelyTraded: Codable {
    let ticker, price, changeAmount, changePercentage: String
    let volume: String

    enum CodingKeys: String, CodingKey {
        case ticker, price
        case changeAmount = "change_amount"
        case changePercentage = "change_percentage"
        case volume
    }
}

