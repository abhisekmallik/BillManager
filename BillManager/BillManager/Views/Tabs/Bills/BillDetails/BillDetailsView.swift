//
//  BillDetailsView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 13/02/2023.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct BillDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var billModel: BillModel
    @Binding var needsRefresh: Bool

    let monthSymbols = Calendar.current.monthSymbols
    
    var years: [Int] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: Date())
        let year = components.year ?? 0
        let years = Array(year..<year+10)
        return years
    }
    
    
    private let currencies = ModelDataManager().currencies
    
    private func getBill(id: String) -> Bill? {
        let predicate = NSPredicate(format: "id == %@", id)
        let bill: Bill? = PersistenceController.shared.fetchObject(predicate: predicate)
        return bill
    }
    
    var body: some View {
        Form {
            VStack {
                
                FloatingLabelTextField($billModel.merchant, placeholder: "Merchant Name", editingChanged: { _ in })
                        .floatingStyle(ThemeTextFieldStyle())
                        .frame(height: 50)
                
                FloatingLabelTextField($billModel.minAmount, placeholder: "Minimum Amount", editingChanged: { _ in })
                    .addValidation(.init(condition: billModel.minAmount.isValid(.currency), errorMessage: "Invalid Minimum Amount")) /// Sets the validation condition.
                                        .isShowError(true) /// Sets the is show error message.
                                        .errorColor(.red) /// Sets the error color.
                                        .keyboardType(.numbersAndPunctuation)
                                        .frame(height: 50)
                
                FloatingLabelTextField($billModel.totalAmount, placeholder: "Total Amount", editingChanged: { _ in })
                    .addValidation(.init(condition: billModel.totalAmount.isValid(.currency), errorMessage: "Invalid Total Amount")) /// Sets the validation condition.
                                        .isShowError(true) /// Sets the is show error message.
                                        .errorColor(.red) /// Sets the error color.
                                        .keyboardType(.numbersAndPunctuation)
                                        .frame(height: 50)
                
                Picker(selection: $billModel.currency) {
                    ForEach(currencies, id: \.name) {
                        Text("\($0.name) (\($0.id))").tag($0.id)
                    }
                } label: {
                    Text("Currency").font(.caption)
                }.pickerStyle(.menu)
                
                
                DatePicker(
                    "Due Date",
                    selection: $billModel.dueDate,
                    displayedComponents: [.date]
                ).font(.caption)
                    
                MonthYearPickerView(month: $billModel.month, year: $billModel.year, pickerLabel: "Period")
                
                Toggle(isOn: $billModel.paid) {
                    Text("Bill Paid").font(.caption)
                }.toggleStyle(.switch).tint(.gray)
            }
        }
    }
}



struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                configuration.label.foregroundColor(.black)
                Image(systemName: configuration.isOn ? "checkmark.square" : "square").foregroundColor(.gray)
                Spacer()
            }
        })
    }
}

struct BillDetailsView_Previews: PreviewProvider {
    @State private static var refresh = true
    static let context = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        BillDetailsView(billModel: BillModel(), needsRefresh: $refresh)
            .environment(\.managedObjectContext, context)
    }
}
