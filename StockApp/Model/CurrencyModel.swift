//
//  CurrencyModel.swift
//  StockApp
//
//  Created by sarim khan on 17/07/2023.
//

import Foundation

struct CurrencyModel: Identifiable {
    let currencyCode:String
    let currencyName:String
    
    var id:String {
        return currencyCode
    }
}
