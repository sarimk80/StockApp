//
//  ForexExchangeModel.swift
//  StockApp
//
//  Created by sarim khan on 19/07/2023.
//

import Foundation

struct ForexExchangeModel: Codable {
    let realtimeCurrencyExchangeRate: RealtimeCurrencyExchangeRate

    enum CodingKeys: String, CodingKey {
        case realtimeCurrencyExchangeRate = "Realtime Currency Exchange Rate"
    }
}

struct RealtimeCurrencyExchangeRate: Codable {
    let the1FromCurrencyCode, the2FromCurrencyName, the3ToCurrencyCode, the4ToCurrencyName: String
    let the5ExchangeRate, the6LastRefreshed, the7TimeZone, the8BidPrice: String
    let the9AskPrice: String

    enum CodingKeys: String, CodingKey {
        case the1FromCurrencyCode = "1. From_Currency Code"
        case the2FromCurrencyName = "2. From_Currency Name"
        case the3ToCurrencyCode = "3. To_Currency Code"
        case the4ToCurrencyName = "4. To_Currency Name"
        case the5ExchangeRate = "5. Exchange Rate"
        case the6LastRefreshed = "6. Last Refreshed"
        case the7TimeZone = "7. Time Zone"
        case the8BidPrice = "8. Bid Price"
        case the9AskPrice = "9. Ask Price"
    }
}
