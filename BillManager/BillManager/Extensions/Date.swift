//
//  Date.swift
//  BillManager
//
//  Created by Abhisek Mallik on 17/02/2023.
//

import Foundation

extension Date {
    
    var currentYear: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        let year = components.year ?? 0
        return year
    }
    
    var currentMonth: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        let month = components.month ?? 0
        return month
    }
    
    func formattedDate(format: DateFormatter.Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        let date = formatter.string(from: self)
        return date
    }
}
