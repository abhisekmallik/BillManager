//
//  MonthYearPickerView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 16/02/2023.
//

import SwiftUI

struct MonthYearPickerView: View {
    private let monthSymbols = Calendar.current.monthSymbols
    
    private var years: [Int] {
        let years = Array(Date().currentYear-10..<Date().currentYear+10)
        return years
    }
    
    @Binding var month: Int
    @Binding var year: Int
    
    @State var pickerLabel: String
    
    var body: some View {
        HStack {
            Text(pickerLabel).font(.caption)
            Spacer()
            Picker(selection: self.$year) {
                ForEach(years, id: \.self) { year in
                    Text(String(year))
                }
            } label: {
                Picker(selection: self.$month) {
                    ForEach(0..<monthSymbols.count, id: \.self) { index in
                        Text(monthSymbols[index])
                    }
                } label: {}.pickerStyle(.menu)
            }.pickerStyle(.menu)
        }
    }
}

struct MonthYearPickerView_Previews: PreviewProvider {
    @State private static var month = Date().currentMonth
    @State private static var year = Date().currentYear
    static var previews: some View {
        MonthYearPickerView(month: $month, year: $year, pickerLabel: "Period")
    }
}
