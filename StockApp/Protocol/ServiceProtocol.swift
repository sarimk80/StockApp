//
//  ServiceProtocol.swift
//  StockApp
//
//  Created by sarim khan on 03/07/2023.
//

import Foundation

protocol ServiceProtocol {
    func searchTicker(sym:String) async throws ->  SearchSym
}
