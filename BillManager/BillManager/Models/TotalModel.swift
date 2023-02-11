//
//  TotalModel.swift
//  BillManager
//
//  Created by Abhisek Mallik on 10/02/2023.
//

import Foundation

struct TotalModel: Identifiable {
    var id = UUID().uuidString
    var currency: String
    var total: Double
}
