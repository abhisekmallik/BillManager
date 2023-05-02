//
//  BillsView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import SwiftUI
import CoreData

struct BillsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var billModels: [Date : [BillModel]] = [:]
    @State private var isBillDetailsPresented = false
    @State private var refreshBills = false
        
    private func reloadData() {
        billModels = getAllBills()
    }
    
    private func getAllBills() -> [Date : [BillModel]] {
        var models: [BillModel] = []
        let sortDescriptors = [
            NSSortDescriptor(keyPath: \Bill.dueDate, ascending: true)
        ]
        let bills: [Bill] = PersistenceController.shared.fetchAllObjects(sortDescriptors: sortDescriptors) ?? []

        bills.forEach { bill in
            let model = getBillModel(bill: bill)
            models.append(model)
        }
        
        let groupedBills = models.sliced(by: [.month, .year], for: \.period!)
        return groupedBills
    }
    
    private func getBillModel(bill: Bill?) -> BillModel {
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
        return model
    }
    
    private func addItem() {
        withAnimation {
            isBillDetailsPresented.toggle()
        }
    }
    
    private func getBill(by id: String) -> Bill? {
        let fetchRequest: NSFetchRequest<Bill> = Bill.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            print("OBJECT FOUND id = \(id) \n Result = \(results)")
            return results.first
        } catch {
            return nil
        }
    }
    var billModelsTmp: [String : [BillModel]] = [:]
    var body: some View {
        NavigationView {
            List {
                ForEach(billModels.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.key < rhs.key
                }), id: \.key) { period, billsArray in
                    Section(period.formattedDate(format: .period)) {
                        ForEach(billsArray) { model in
                            NavigationLink {                                
                                BillDetailsView(billModel: model, needsRefresh: $refreshBills)
                                    .environment(\.managedObjectContext, viewContext)
                                    .navigationBarBackButtonHidden()
                                    .onDisappear {
                                    reloadData()
                                }
                            } label: {
                                BillsItemView(bill: model)
                            }
                        }.onDelete { indexSet in
                            withAnimation {
                                indexSet.forEach { index in
                                    print("Object at index for DELETE \(index)")
                                    let model = billsArray[index]
                                    print("Object for DELETE \(model)")
                                    if let bill = getBill(by: model.id) {
                                        viewContext.delete(bill)
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
                    }
                }
            }
            .refreshable {
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
            .sheet(isPresented: $isBillDetailsPresented,
                   onDismiss: {
                        reloadData()
                    },
                   content: {
                        NavigationView {
                            BillDetailsView(billModel: BillModel(), needsRefresh: $refreshBills)
                                .environment(\.managedObjectContext, viewContext)
                        }
                    })
            .navigationTitle("Bills")
            .onAppear {
                reloadData()
            }
        }
    }
}

struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
