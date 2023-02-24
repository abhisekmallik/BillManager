//
//  String.swift
//  BillManager
//
//  Created by Abhisek Mallik on 22/02/2023.
//

import Foundation

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {

            let dateFormatter = DateFormatter()
//            dateFormatter.timeZone = TimeZone(identifier: "GMT+4")
//            dateFormatter.locale = Locale(identifier: "en-AE")
            dateFormatter.calendar = Calendar(identifier: .gregorian)
            dateFormatter.dateFormat = format
            let date = dateFormatter.date(from: self)
            return date
        }
}
