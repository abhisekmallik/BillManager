//
//  AccountItemView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 10/02/2023.
//

import SwiftUI
import CoreData

struct AccountItemView: View {
    @Binding var account: AccountModel
    
    var body: some View {
        VStack {
            HStack {
                Text(account.bank).font(.headline)
                Spacer()
                
                Text("\(account.type) Account").font(.subheadline)
            }
            HStack {
                Text(account.accountHolder).font(.footnote)
                Spacer()
                Text(account.currency).font(.headline)
                Text(account.balance).font(.subheadline)
            }
        }
    }
}

struct AccountItemView_Previews: PreviewProvider {
   @State private static var account = {
       let context = PersistenceController.preview.container.viewContext
       
       let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Account.bank, ascending: true), NSSortDescriptor(keyPath: \Account.balance, ascending: true)]
       let results = try? context.fetch(fetchRequest)
       let account = results![1];
       var model = AccountModel()
       model.id = account.id?.uuidString ?? UUID().uuidString
       model.accountNumber = account.accountNumber ?? ""
       model.bank = account.bank ?? ""
       model.accountHolder = account.accountHolder ?? ""
       model.balance = String(format: "%.2f", account.balance)
       model.currency = account.currency ?? ""
       model.type = account.type ?? ""
       return model
    }()
    
    static var previews: some View {
        AccountItemView(account: $account)
    }
}
