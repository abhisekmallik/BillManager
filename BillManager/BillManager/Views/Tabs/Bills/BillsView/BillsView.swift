//
//  BillsView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import SwiftUI

struct BillsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var accountModels: [AccountModel] = []
    @State private var isSheetPresented = false
    @State private var refresh = false
        
    private func reloadData() {
        
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach($accountModels) { model in
                        NavigationLink {
//                            AccountDetailsView(accountModel: model.wrappedValue,
//                                               needsRefresh: $refresh)
//                                .environment(\.managedObjectContext, viewContext)
//                                .navigationBarBackButtonHidden()
//                                .onDisappear {
//                                    print("onDisappear \(refresh)")
//                                    reloadData()
//                                }
                        } label: {
//                            AccountItemView(account: model)
                        }
                    }
//                    .onDelete(perform: deleteItems)
                }
                
                Section {
//                    ForEach(totalsByCurrencies) { model in
//                        HStack {
//                            Text("Total Balance").font(.headline)
//                            Spacer()
//                            Text(model.currency).font(.headline)
//                            Text("\(model.total, specifier: "%.2f")").font(.subheadline)
//                        }
//                    }
                    
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
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
                }
            }
            .sheet(isPresented: $isSheetPresented,
                   onDismiss: {
                        reloadData()
                    },
                   content: {
                        NavigationView {
//                            AccountDetailsView(accountModel: AccountModel(), needsRefresh: $refresh)
//                            .environment(\.managedObjectContext, viewContext)
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
        BillsView()
    }
}
