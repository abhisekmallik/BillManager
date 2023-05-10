//
//  ReportsView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import SwiftUI

struct ReportsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var menuOptions = ["Transactions", "Monthly expenses"]
    
    var body: some View {
        NavigationView {
            
            List {
                Section {
                    ForEach($menuOptions, id: \.self) { option in
                        NavigationLink {
                            SettingsView()
                                .environment(\.managedObjectContext, viewContext)
//                                .navigationBarBackButtonHidden()
                                .onDisappear {
                                    //                                    print("onDisappear \(refresh)")
                                    //                                    reloadData()
                                }
                        } label: {
                            Text(option.wrappedValue)
                        }
                    }
                }
            }
            .refreshable {
                print("Refreshing")
                //reloadData()
            }
            .navigationTitle("Reports")
            .onAppear {
                //reloadData()
            }
        }
    }
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
    }
}
