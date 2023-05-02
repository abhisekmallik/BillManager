//
//  HomeView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var tabSelection: Tab = .accounts
    
    enum Tab {
        case accounts
        case bills
        case reports
        case settings
    }

    var body: some View {
        TabView(selection: $tabSelection) {
            AccountListView().tabItem {
                Label("Accounts", systemImage: "note.text.badge.plus")
            }.tag(Tab.accounts)
            BillsView().tabItem {
                //"square.stack.fill"
                Label("Biils", systemImage: "doc.on.clipboard.fill")
            }.tag(Tab.bills)
            ReportsView().tabItem {
                Label("Reports", systemImage: "tray.full.fill")
            }.tag(Tab.reports)
            SettingsView().tabItem {
                Label("Settings", systemImage: "gear")
            }.tag(Tab.settings)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
