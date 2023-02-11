//
//  CurrencyModel.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import Foundation

struct CurrencyModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var symbol: String
}
