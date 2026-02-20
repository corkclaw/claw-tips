//
//  BillInputView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI

struct BillInputView: View {
    @Binding var billAmount: Decimal
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Bill Amount")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            HStack {
                Text("$")
                    .font(.title)
                    .foregroundStyle(.secondary)
                
                TextField("0.00", value: $billAmount, format: .number)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    BillInputView(billAmount: .constant(47.50))
        .padding()
}
