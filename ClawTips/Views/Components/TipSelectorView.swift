//
//  TipSelectorView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI

struct TipSelectorView: View {
    @Binding var tipPercentage: Int
    let quickTipOptions: [Int]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tip Percentage")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            // Quick Select Buttons
            HStack(spacing: 12) {
                ForEach(quickTipOptions, id: \.self) { percentage in
                    Button {
                        tipPercentage = percentage
                    } label: {
                        Text("\(percentage)%")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                tipPercentage == percentage 
                                    ? Color.accentColor 
                                    : Color(.systemGray6)
                            )
                            .foregroundStyle(
                                tipPercentage == percentage 
                                    ? .white 
                                    : .primary
                            )
                            .cornerRadius(10)
                    }
                }
            }
            
            // Custom Percentage Slider
            HStack {
                Text("Custom:")
                    .foregroundStyle(.secondary)
                
                Slider(value: Binding(
                    get: { Double(tipPercentage) },
                    set: { tipPercentage = Int($0) }
                ), in: 0...30, step: 1)
                
                Text("\(tipPercentage)%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(width: 60)
            }
        }
    }
}

#Preview {
    TipSelectorView(
        tipPercentage: .constant(18),
        quickTipOptions: [15, 18, 20]
    )
    .padding()
}
