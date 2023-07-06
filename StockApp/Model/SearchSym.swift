//
//  SearchSym.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation


struct SearchSym: Codable {
    let bestMatches: [BestMatch]
}

struct BestMatch: Codable , Hashable {
    let the1Symbol, the2Name, the3Type, the4Region: String
    let the5MarketOpen, the6MarketClose, the7Timezone, the8Currency: String
    let the9MatchScore: String
    
    enum CodingKeys: String, CodingKey {
           case the1Symbol = "1. symbol"
           case the2Name = "2. name"
           case the3Type = "3. type"
           case the4Region = "4. region"
           case the5MarketOpen = "5. marketOpen"
           case the6MarketClose = "6. marketClose"
           case the7Timezone = "7. timezone"
           case the8Currency = "8. currency"
           case the9MatchScore = "9. matchScore"
       }
}
