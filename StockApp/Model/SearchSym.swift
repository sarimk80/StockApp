//
//  SearchSym.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation
import SwiftData


class SearchSym: Codable {
    let bestMatches: [BestMatch]
}

@Model
class BestMatch: Codable , Hashable {
    @Attribute(.unique) let the1Symbol:String
    let the2Name, the3Type, the4Region: String
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
    init(the1Symbol: String, the2Name: String, the3Type: String, the4Region: String, the5MarketOpen: String, the6MarketClose: String, the7Timezone: String, the8Currency: String, the9MatchScore: String) {
        self.the1Symbol = the1Symbol
        self.the2Name = the2Name
        self.the3Type = the3Type
        self.the4Region = the4Region
        self.the5MarketOpen = the5MarketOpen
        self.the6MarketClose = the6MarketClose
        self.the7Timezone = the7Timezone
        self.the8Currency = the8Currency
        self.the9MatchScore = the9MatchScore
    }
    
    required init(from decoder:Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.the1Symbol = try values.decodeIfPresent(String.self,forKey: .the1Symbol)!
        self.the2Name = try values.decodeIfPresent(String.self,forKey: .the2Name)!
        self.the3Type = try values.decodeIfPresent(String.self,forKey: .the3Type)!
        self.the4Region = try values.decodeIfPresent(String.self,forKey: .the4Region)!
        self.the5MarketOpen = try values.decodeIfPresent(String.self,forKey: .the5MarketOpen)!
        self.the6MarketClose = try values.decodeIfPresent(String.self,forKey: .the6MarketClose)!
        self.the7Timezone = try values.decodeIfPresent(String.self,forKey: .the7Timezone)!
        self.the8Currency = try values.decodeIfPresent(String.self,forKey: .the8Currency)!
        self.the9MatchScore = try values.decodeIfPresent(String.self,forKey: .the9MatchScore)!
    }
    
    func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(the1Symbol, forKey: .the1Symbol)
          try container.encode(the2Name, forKey: .the2Name)
          try container.encode(the3Type, forKey: .the3Type)
          try container.encode(the4Region, forKey: .the4Region)
          try container.encode(the5MarketOpen, forKey: .the5MarketOpen)
          try container.encode(the6MarketClose, forKey: .the6MarketClose)
          try container.encode(the7Timezone, forKey: .the7Timezone)
          try container.encode(the8Currency, forKey: .the8Currency)
          try container.encode(the9MatchScore, forKey: .the9MatchScore)
      }
    
   
}
