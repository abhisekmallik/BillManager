//
//  AccountModel.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import Foundation

struct AccountModel: Identifiable {
    var id = UUID().uuidString
    var bank = ""
    var accountNumber = ""
    var accountHolder = ""
    var balance = ""
    var currency = "AED"
    var type = "Current"
}
