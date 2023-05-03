//
//  BillDetailsView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 13/02/2023.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import CoreData

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
    
    private let accountModels = PersistenceDataManager.shared.getAllAccountsIn()
    
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
                    
                MonthYearPickerView(month: $billModel.editMonth, year: $billModel.year, pickerLabel: "Period")
                
                Toggle(isOn: $billModel.paid) {
                    Text("Bill Paid").font(.caption)
                }.toggleStyle(.switch).tint(.gray)
                
//                if billModel.paid {
                    DatePicker(
                        "Paid Date",
                        selection: Binding<Date>(get: { billModel.paidDate ?? Date() }, set: { billModel.paidDate = $0 }),
                        displayedComponents: [.date]
                    ).font(.caption).disabled(!billModel.paid)
//                }
                
                
                Picker(selection: $billModel.bankPaidFrom) {
                    ForEach(accountModels, id: \.self) {
                        Text("\($0.bank!) | \($0.type!) (\($0.accountNumber!))").tag($0.id!.uuidString)
                    }
                } label: {
                    Text("Paid From").font(.caption)
                }.pickerStyle(.menu).disabled(!billModel.paid)
                
//                Text("Selected account: \(String(describing: $billModel.bankPaidFrom))").font(.caption)

            }
            .navigationTitle("Bill Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                needsRefresh.toggle()
                dismiss()
            }))
            .navigationBarItems(trailing: Button((PersistenceDataManager.shared.getBill(id: billModel.id) != nil) ? "Update" : "Save", action: {
                withAnimation {
                    defer {
                        needsRefresh.toggle()
                        dismiss()
                    }
                    
                    
                    let bill = PersistenceDataManager.shared.getBill(id: billModel.id)
                    print("bill FOUND \(String(describing: bill))")
                    print("account id: \(String(describing: billModel.bankPaidFrom))")
                    if !billModel.bankPaidFrom.isEmpty {
                        print("account model: \(String(describing: PersistenceDataManager.shared.getAccount(id: billModel.bankPaidFrom)))")
                    }
                    let dataModel = bill ?? Bill(context: viewContext)
                    
                    print("dataModel BEFORE \(dataModel)")
                    dataModel.id = UUID(uuidString: billModel.id)
                    dataModel.currency = billModel.currency
                    dataModel.dueDate = billModel.dueDate
                    dataModel.merchant = billModel.merchant
                    dataModel.minAmount = Double(billModel.minAmount) ?? 0.0
                    dataModel.totalAmount = Double(billModel.totalAmount) ?? 0.0
                    billModel.month = billModel.editMonth + 1
                    dataModel.period = billModel.period
                    dataModel.paidDate = billModel.paidDate
                    if !billModel.bankPaidFrom.isEmpty {
                        let account = PersistenceDataManager.shared.getAccount(id: billModel.bankPaidFrom)
                        if !dataModel.paid {
                            account?.balance -= dataModel.totalAmount
                        }
                        
                        print("account model: \(String(describing: PersistenceDataManager.shared.getAccount(id: billModel.bankPaidFrom)))")
                        dataModel.paidFromAccount = account
                    }
                    
                    dataModel.paid = billModel.paid
                    
                    print("dataModel AFTER \(dataModel)")

                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        print("Unresolved error \(nsError), \(nsError.userInfo)")
                        viewContext.rollback()
                    }
                }

            }))
        }
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
