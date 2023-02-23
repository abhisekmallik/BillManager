//
//  Persistence.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
//    static var shared: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//
//        let account = Account(context: viewContext)
//        account.bank = "ADCB Bank"
//        account.accountNumber = "1110001"
//        account.balance = 10000
//        account.accountHolder = "Abhisek Mallik"
//        account.currency = "AED"
//        account.type = "Current"
//
//        let account2 = Account(context: viewContext)
//        account2.bank = "ADCB Bank"
//        account.accountNumber = "1110002"
//        account2.balance = 21000
//        account2.accountHolder = "Abhisek Mallik"
//        account2.currency = "AED"
//        account2.type = "Savings"
//
//        let account3 = Account(context: viewContext)
//        account3.bank = "ENBD Bank"
//        account.accountNumber = "1110003"
//        account3.balance = 36000
//        account3.accountHolder = "Arpita Mallik"
//        account3.currency = "AED"
//        account3.type = "Current"
//
//        let account4 = Account(context: viewContext)
//        account4.bank = "ICICI Bank"
//        account.accountNumber = "1110004"
//        account4.balance = 30000
//        account4.accountHolder = "Abhisek Mallik"
//        account4.currency = "INR"
//        account4.type = "Savings"
//
//        let account5 = Account(context: viewContext)
//        account5.bank = "HDFC Bank"
//        account.accountNumber = "1110005"
//        account5.balance = 17000
//        account5.accountHolder = "Abhisek Mallik"
//        account5.currency = "INR"
//        account5.type = "Savings"
//
//        let account6 = Account(context: viewContext)
//        account6.bank = "Citi Bank"
//        account.accountNumber = "1110006"
//        account6.balance = 12000
//        account6.accountHolder = "Abhisek Mallik"
//        account6.currency = "INR"
//        account6.type = "Savings"
//
//
//        let bill1 = Bill(context: viewContext)
//        bill1.id = UUID()
//        bill1.currency = "AED"
//        bill1.dueDate = "27-02-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//        bill1.merchant = "DEWA"
//        bill1.minAmount = 400
//        bill1.totalAmount = 500
//        bill1.paid = true
//        bill1.period = "02-02-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//
//        let bill2 = Bill(context: viewContext)
//        bill2.id = UUID()
//        bill2.currency = "AED"
//        bill2.dueDate = "24-02-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//        bill2.merchant = "Mashreq"
//        bill2.minAmount = 400
//        bill2.totalAmount = 500
//        bill2.paid = false
//        bill2.period = "02-02-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//
//        let bill3 = Bill(context: viewContext)
//        bill3.id = UUID()
//        bill3.currency = "AED"
//        bill3.dueDate = "27-03-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//        bill3.merchant = "DEWA"
//        bill3.minAmount = 400
//        bill3.totalAmount = 500
//        bill3.paid = false
//        bill3.period = "02-03-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//
//        let bill4 = Bill(context: viewContext)
//        bill4.id = UUID()
//        bill4.currency = "AED"
//        bill4.dueDate = "24-04-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//        bill4.merchant = "Mashreq"
//        bill4.minAmount = 400
//        bill4.totalAmount = 500
//        bill4.paid = false
//        bill4.period = "02-04-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
//
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//
//        return result
//    }()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let account = Account(context: viewContext)
        account.bank = "ADCB Bank"
        account.accountNumber = "1110001"
        account.balance = 10000
        account.accountHolder = "Abhisek Mallik"
        account.currency = "AED"
        account.type = "Current"
        
        let account2 = Account(context: viewContext)
        account2.bank = "ADCB Bank"
        account.accountNumber = "1110002"
        account2.balance = 21000
        account2.accountHolder = "Abhisek Mallik"
        account2.currency = "AED"
        account2.type = "Savings"
        
        let account3 = Account(context: viewContext)
        account3.bank = "ENBD Bank"
        account.accountNumber = "1110003"
        account3.balance = 36000
        account3.accountHolder = "Arpita Mallik"
        account3.currency = "AED"
        account3.type = "Current"
        
        let account4 = Account(context: viewContext)
        account4.bank = "ICICI Bank"
        account.accountNumber = "1110004"
        account4.balance = 30000
        account4.accountHolder = "Abhisek Mallik"
        account4.currency = "INR"
        account4.type = "Savings"
        
        let account5 = Account(context: viewContext)
        account5.bank = "HDFC Bank"
        account.accountNumber = "1110005"
        account5.balance = 17000
        account5.accountHolder = "Abhisek Mallik"
        account5.currency = "INR"
        account5.type = "Savings"
        
        let account6 = Account(context: viewContext)
        account6.bank = "Citi Bank"
        account.accountNumber = "1110006"
        account6.balance = 12000
        account6.accountHolder = "Abhisek Mallik"
        account6.currency = "INR"
        account6.type = "Savings"
        
        
        let bill1 = Bill(context: viewContext)
        bill1.id = UUID()
        bill1.currency = "AED"
        bill1.dueDate = "27-02-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
        bill1.merchant = "DEWA"
        bill1.minAmount = 400
        bill1.totalAmount = 500
        bill1.paid = false
        bill1.period = "01-02-2023".toDate(withFormat: "dd-MM-yyyy") ?? Date()
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "BillManager")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func fetchAllObjects<T: NSManagedObject>(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T]? {
        let fetchRequest = T.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        do {
            let results = try container.viewContext.fetch(fetchRequest) as? [T]
            return results
        } catch {
            return nil
        }
    }
    
    func fetchObject<T: NSManagedObject>(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> T? {
        let results: [T]? = fetchAllObjects(predicate: predicate, sortDescriptors: sortDescriptors)
        let result = results?.first
        return result
    }
}
