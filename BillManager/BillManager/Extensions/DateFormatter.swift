//
//  DateFormatter.swift
//  BillManager
//
//  Created by Abhisek Mallik on 23/02/2023.
//

import Foundation

extension DateFormatter {
    
    @frozen public enum Format: String {
        case period = "MMM yyyy"
        case server = "yyyy-MM-dd HH:mm:ss"
        case dueDate = "EEE, dd MMM yyyy"
    }
}
