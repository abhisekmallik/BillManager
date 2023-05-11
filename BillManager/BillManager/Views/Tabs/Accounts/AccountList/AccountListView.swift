//
//  AccountListView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import SwiftUI
import CoreData

struct AccountListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var accountModels: [AccountModel] = []
    @State private var isAccountDetailsPresented = false
    @State private var refresh = false
        
    private func reloadData() {
        accountModels = getAllAccounts()
    }
    
    private func getAllAccounts() -> [AccountModel] {
        accountModels = []
        let accounts = PersistenceDataManager.shared.getAllAccounts()

        accounts.forEach { account in            
            let model = PersistenceDataManager.shared.getAccountModel(account: account)
            
            accountModels.append(model)
        }
        return accountModels
    }
    
    private var totalsByCurrencies: [TotalModel]  {
        let currencyGroup = Dictionary(grouping: accountModels, by: {$0.currency})
        var totals = [TotalModel]()
        for (key, value) in currencyGroup {
            let allBalances = value.map({ Double($0.balance ) ?? 0.0 })
            let total = allBalances.reduce(0, +)
            let totalModel = TotalModel(currency: key, total: total)
            totals.append(totalModel)
            
        }
        return totals
    }
    
    private func addItem() {
        withAnimation {
            isAccountDetailsPresented.toggle()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.forEach { index in
                let model = accountModels[index]
                print("Object for DELETE \(model)")
                if let account = PersistenceDataManager.shared.getAccount(by: model.accountNumber) {
                    print("account Object for DELETE \(account)")
                    viewContext.delete(account)
                }
            }

            do {
                try viewContext.save()
                reloadData()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach($accountModels) { model in
                        NavigationLink {
                            AccountDetailsView(accountModel: model.wrappedValue,
                                               needsRefresh: $refresh)
                                .environment(\.managedObjectContext, viewContext)
                                .navigationBarBackButtonHidden()
                                .onDisappear {
                                    print("onDisappear \(refresh)")
                                    reloadData()
                                }
                        } label: {
                            AccountItemView(account: model)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                Section("Balance") {
                    ForEach(totalsByCurrencies) { model in
                        HStack {
                            Text("Total Balance").font(.headline)
                            Spacer()
                            Text(model.currency).font(.headline)
                            Text("\(model.total, specifier: "%.2f")").font(.subheadline)
                        }
                    }
                }
            }
            .refreshable {
                print("Refreshing")
                reloadData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAccountDetailsPresented,
                   onDismiss: {
                        reloadData()
                    },
                   content: {
                        NavigationView {
                            AccountDetailsView(accountModel: AccountModel(), needsRefresh: $refresh)
                            .environment(\.managedObjectContext, viewContext)
                        }
                    })
            .navigationTitle("Accounts")
            .onAppear {
                reloadData()
            }
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
