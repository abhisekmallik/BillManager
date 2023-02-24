//
//  Array.swift
//  BillManager
//
//  Created by Abhisek Mallik on 22/02/2023.
//

import Foundation

extension Array {
    
  func sliced(by dateComponents: Set<Calendar.Component>, for key: KeyPath<Element, Date>) -> [Date: [Element]] {
    let initial: [Date: [Element]] = [:]
    let groupedByDateComponents = reduce(into: initial) { acc, cur in
        var calendar = Calendar.current
        calendar.timeZone = .current
        let components = calendar.dateComponents(dateComponents, from: cur[keyPath: key])
        let date = calendar.date(from: components)!
//        print("IDENTIFIED DATE \(date.formattedDate(format: .dueDate)) | COMPONENTS \(components)")
        let existing = acc[date] ?? []
        acc[date] = existing + [cur]
    }

    return groupedByDateComponents
  }
}
