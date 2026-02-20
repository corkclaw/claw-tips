//
//  ContentView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI

struct ContentView: View {
    @State private var calculator = TipCalculator()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Bill Input Section
                BillInputView(billAmount: $calculator.billAmount)
                
                Divider()
                
                // Tip Selection Section
                TipSelectorView(
                    tipPercentage: $calculator.tipPercentage,
                    quickTipOptions: calculator.configuration.quickTipOptions
                )
                
                Divider()
                
                // Split Controls
                SplitControlView(splitCount: $calculator.splitCount)
                
                Divider()
                
                // Results Display
                ResultsView(calculator: calculator)
                
                Spacer()
            }
            .padding()
            .navigationTitle("🦀 Claw Tips")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Clear") {
                        calculator.reset()
                    }
                    .disabled(calculator.billAmount == 0)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
