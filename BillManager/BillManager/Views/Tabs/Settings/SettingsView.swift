//
//  SettingsView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Text("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
