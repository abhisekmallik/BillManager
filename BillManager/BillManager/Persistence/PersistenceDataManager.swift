//
//  PersistenceDataManager.swift
//  BillManager
//
//  Created by Abhisek Mallik on 03/05/2023.
//

import Foundation
import CoreData

struct PersistenceDataManager {
    static let shared = PersistenceDataManager()
    private let controller = PersistenceController.shared
    
    /// Bill
    func getBill(id: String) -> Bill? {
        let predicate = NSPredicate(format: "id == %@", id)
        let object: Bill? = controller.fetchObject(predicate: predicate)
        return object
    }
    
    func getBillModel(bill: Bill?) -> BillModel {
        guard let bill = bill else {
            return BillModel()
        }
        let month = bill.period?.currentMonth ?? Date().currentMonth
        var model = BillModel()
        model.id = bill.id?.uuidString ?? UUID().uuidString
        model.currency = bill.currency ?? ""
        model.dueDate = bill.dueDate ?? Date()
        model.merchant = bill.merchant ?? ""
        model.totalAmount = String(format: "%.2f", bill.totalAmount)
        model.minAmount = String(format: "%.2f", bill.minAmount)
        model.paid = bill.paid
        model.year = bill.period?.currentYear ?? Date().currentYear
        model.month = month
        model.editMonth = month - 1
        model.paidDate = bill.paidDate ?? Date()
        model.bankPaidFrom = bill.paidFromAccount?.id?.uuidString ?? ""
        return model
    }
    
    /// Account
    func getAllAccountsIn(currency: String? = nil) -> [Account] {
        var predicate: NSPredicate? = nil
        if let currency = currency {
            predicate = NSPredicate(format: "currency == %@", currency)
        }
        let accounts = getAllAccounts(predicate: predicate)
        return accounts
    }
    
    func getAllAccounts(predicate: NSPredicate? = nil) -> [Account] {
        let sortDescriptors = [
            NSSortDescriptor(keyPath: \Account.bank, ascending: true),
            NSSortDescriptor(keyPath: \Account.accountNumber, ascending: false)
        ]
        let accounts: [Account] = controller.fetchAllObjects(predicate: predicate, sortDescriptors: sortDescriptors) ?? []

        return accounts
    }
    
    func getAccount(predicate: NSPredicate) -> Account? {
        let account: Account? = controller.fetchObject(predicate: predicate)
        return account
    }
    
    func getAccount(id: String) -> Account? {
        let predicate = NSPredicate(format: "id == %@", id)
        let account = getAccount(predicate: predicate)
        return account
    }
    
    func getAccount(by accountNumber: String) -> Account? {
        let predicate = NSPredicate(format: "accountNumber == %@", accountNumber)
        let account = getAccount(predicate: predicate)
        return account
    }
    
    func getAccountModel(account: Account?) -> AccountModel {
        guard let account = account else {
            return AccountModel()
        }
        var model = AccountModel()
        model.id = account.id?.uuidString ?? UUID().uuidString
        model.accountNumber = account.accountNumber ?? ""
        model.bank = account.bank ?? ""
        model.accountHolder = account.accountHolder ?? ""
        model.balance = String(format: "%.2f", account.balance)
        model.currency = account.currency ?? ""
        model.type = account.type ?? ""
        return model
    }
}
