//
//  AccountDetailsView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import SwiftUI
import CoreData
import FloatingLabelTextFieldSwiftUI

struct AccountDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var accountModel: AccountModel
    @Binding var needsRefresh: Bool
    
    private let currencies = ModelDataManager().currencies
    private let types = ["Current", "Savings"]
    
    var body: some View {
        Form {
            Section {
                VStack {
                    FloatingLabelTextField($accountModel.bank, placeholder: "Bank Name", editingChanged:{ _ in })
                            .floatingStyle(ThemeTextFieldStyle())
                            .frame(height: 50)
                    
                    FloatingLabelTextField($accountModel.accountNumber, placeholder: "Account Number", editingChanged: { _ in })
                            .floatingStyle(ThemeTextFieldStyle())
                            .frame(height: 50)
                    
                    FloatingLabelTextField($accountModel.accountHolder, placeholder: "Account Holder", editingChanged: { _ in })
                            .floatingStyle(ThemeTextFieldStyle())
                            .frame(height: 50)
                    
                    FloatingLabelTextField($accountModel.balance, placeholder: "Account Balance", editingChanged: { _ in })
                        .addValidation(.init(condition: accountModel.balance.isValid(.currency), errorMessage: "Invalid Amount")) /// Sets the validation condition.
                                            .isShowError(true) /// Sets the is show error message.
                                            .errorColor(.red) /// Sets the error color.
                                            .keyboardType(.numbersAndPunctuation)
                                            .frame(height: 50)
                    
                    
                    Spacer()
                }
            }
            Section {
                Picker(selection: $accountModel.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                } label: {
                    Text("Account Type").font(.caption)
                }.pickerStyle(.menu)
                
                Divider()
                VStack {
                    Picker(selection: $accountModel.currency) {
                        ForEach(currencies, id: \.name) {
                            Text("\($0.name) (\($0.id))").tag($0.id)
                        }
                    } label: {
                        Text("Currency").font(.caption)
                    }.pickerStyle(.menu)
                }
            }
            .navigationTitle("Account Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                needsRefresh.toggle()
                dismiss()
            }))
            .navigationBarItems(trailing: Button("Done", action: {
                withAnimation {
                    defer {
                        needsRefresh.toggle()
                        dismiss()
                    }
                    
                    
                    let account = PersistenceDataManager.shared.getAccount(id: accountModel.id)
                    print("account FOUND \(String(describing: account))")
                    
                    let dataModel = account ?? Account(context: viewContext)
                    
                    print("dataModel BEFORE \(dataModel)")
                    dataModel.id = UUID(uuidString: accountModel.id)
                    dataModel.accountHolder = accountModel.accountHolder
                    dataModel.accountNumber = accountModel.accountNumber
                    dataModel.bank = accountModel.bank
                    dataModel.balance = Double(accountModel.balance) ?? 0.0
                    dataModel.currency = accountModel.currency
                    dataModel.type = accountModel.type
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

struct AccountDetailsView_Previews: PreviewProvider {
    @State private static var refresh = true
    static let context = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        AccountDetailsView(
            accountModel: AccountModel(), needsRefresh: $refresh)
        .environment(\.managedObjectContext, context)
    }
}
