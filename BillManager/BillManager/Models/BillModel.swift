//
//  BillModel.swift
//  BillManager
//
//  Created by Abhisek Mallik on 13/02/2023.
//

import Foundation
import SwiftUI

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
    var editMonth = Date().currentMonth - 1
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
        formatter.dateFormat = DateFormatter.Format.period.rawValue
        let date = formatter.string(from: period)
        return date
    }
    var formattedDueDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.Format.dueDate.rawValue
        let date = formatter.string(from: dueDate)
        return date
    }
    var dueDateColor: Color {
        guard !paid else {
            return .black
        }
        let result = dueDate.compare(Date())
        switch result {
        case .orderedSame, .orderedAscending:
            return .red
        default:
            return .black
        }
    }
    var paidColor: Color {
        return paid ? .green : .red
    }
}
