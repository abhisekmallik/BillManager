//
//  BillsItemView.swift
//  BillManager
//
//  Created by Abhisek Mallik on 21/02/2023.
//

import SwiftUI

struct BillsItemView: View {
    @Environment(\.colorScheme) private var colorScheme
    var bill: BillModel
    
    var body: some View {
        VStack {
            HStack {
                Text(bill.merchant).font(.headline)
                Spacer()
                
                Text(bill.formattedDueDate).font(.subheadline).foregroundColor(bill.dueDateColor(colorScheme: colorScheme)).fontWeight(.bold)
            }
            HStack {
                Text(bill.paid ? "Paid" : "Unpaid").font(.footnote).foregroundColor(bill.paidColor).fontWeight(.bold)
                Spacer()
                Text(bill.currency).font(.headline)
                Text(bill.totalAmount).font(.subheadline)
            }
        }
    }
}

struct BillsItemView_Previews: PreviewProvider {
    @State private static var model = {
        var model = BillModel()
        model.merchant = "DEWA"
        model.minAmount = String(format: "%.2f", Double(400))
        model.totalAmount = String(format: "%.2f", Double(500))
        model.currency = "AED"
        model.paid = true
        return model
    }()
    
    static var previews: some View {
        BillsItemView(bill: model)
    }
}
