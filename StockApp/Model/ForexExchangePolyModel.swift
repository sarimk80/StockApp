//
//  ForexExchangePolyModel.swift
//  StockApp
//
//  Created by sarim khan on 20/07/2023.
//

import Foundation

struct ForexExchangePolyModel: Codable {
    let ticker: String
    let queryCount, resultsCount: Int
    let adjusted: Bool
    let myResults: [MyResult]
    let status, requestID: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case myResults = "results"
        case ticker, queryCount, resultsCount, adjusted, status
        case requestID = "request_id"
        case count
    }
}

struct MyResult: Codable {
    let t: String
    let v: Int
    let vw, o, c, h: Double
    let l: Double
    let resultT, n: Int

    enum CodingKeys: String, CodingKey {
        case t = "T"
        case v, vw, o, c, h, l
        case resultT = "t"
        case n
    }
}
