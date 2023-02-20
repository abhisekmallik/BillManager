//
//  BillModel.swift
//  BillManager
//
//  Created by Abhisek Mallik on 13/02/2023.
//

import Foundation

struct BillModel: Identifiable {
    var id = UUID().uuidString
    var currency = ""
    var dueDate = Date()
    var merchant = ""
    var minAmount = ""
    var paid = false
    var totalAmount = ""
    var year = Date().currentYear
    var month = Date().currentMonth
    var period: Date? {
        var dateCmpt = DateComponents()
        dateCmpt.month = month
        dateCmpt.year = year
        let calendar = Calendar.current
        let date = calendar.date(from: dateCmpt)
        return date
    }
    var formattedPeriod: String {
        guard let period = period else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let date = formatter.string(from: period)
        return date
    }
}
