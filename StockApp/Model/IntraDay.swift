//
//  IntraDay.swift
//  StockApp
//
//  Created by sarim khan on 06/07/2023.
//

import Foundation

struct IntraDay: Codable {
    let ticker: String
    let queryCount, resultsCount: Int
    let adjusted: Bool
    let results: [Result]
    let status, requestID: String
    let count: Int
    let nextURL: String?

    enum CodingKeys: String, CodingKey {
        case ticker, queryCount, resultsCount, adjusted, results, status
        case requestID = "request_id"
        case count
        case nextURL = "next_url"
    }
}

struct Result: Codable,Identifiable {
    let v: Int
    let vw, o, c, h: Double
    let l: Double
    let t, n: Int
    
    var id: String { String(t) }
    
    var customDate : Date { Date(timeIntervalSince1970: (Double(t)/1000) ) }
}


