//
//  ResultsView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI
import Combine

struct ResultsView: View {
    let calculator: TipCalculator
    @StateObject private var paymentCoordinator = PaymentCoordinator()
    @State private var showingPaymentAlert = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Summary")
                .font(.headline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Bill Amount
            ResultRow(
                label: "Bill",
                amount: calculator.formattedBillAmount,
                isHighlight: false
            )
            
            // Tip Amount
            ResultRow(
                label: "Tip (\(calculator.tipPercentage)%)",
                amount: calculator.formattedTipAmount,
                isHighlight: false
            )
            
            Divider()
            
            // Total Amount
            ResultRow(
                label: "Total",
                amount: calculator.formattedTotalAmount,
                isHighlight: true
            )
            
            if calculator.splitCount > 1 {
                Divider()
                
                // Per Person Amount
                VStack(spacing: 8) {
                    Text("Each Person Pays")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(calculator.formattedAmountPerPerson)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.accentColor)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(12)
                
                // Send Payment Button
                Button {
                    handleSendPayment()
                } label: {
                    HStack {
                        Image(systemName: "paperplane.fill")
                        Text("Send via Apple Cash")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
                .disabled(!paymentCoordinator.canSendMessages)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .sheet(isPresented: $paymentCoordinator.isShowingContactPicker) {
            ContactPickerView(
                isPresented: $paymentCoordinator.isShowingContactPicker,
                onSelect: { contacts in
                    paymentCoordinator.didSelectContacts(contacts)
                }
            )
        }
        .sheet(isPresented: $paymentCoordinator.isShowingMessageComposer) {
            if let composer = paymentCoordinator.createMessageComposer() {
                MessageComposerView(
                    composer: composer,
                    delegate: paymentCoordinator
                )
            }
        }
        .alert("Payment Error", isPresented: .constant(paymentCoordinator.errorMessage != nil)) {
            Button("OK") {
                paymentCoordinator.errorMessage = nil
            }
        } message: {
            if let error = paymentCoordinator.errorMessage {
                Text(error)
            }
        }
    }
    
    private func handleSendPayment() {
        let amount = calculator.result.amountPerPerson
        let message = "Your share from our meal"
        paymentCoordinator.sendPayment(amount: amount, message: message)
    }
}

struct ResultRow: View {
    let label: String
    let amount: String
    let isHighlight: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .font(isHighlight ? .title3 : .body)
                .fontWeight(isHighlight ? .semibold : .regular)
            
            Spacer()
            
            Text(amount)
                .font(isHighlight ? .title2 : .title3)
                .fontWeight(isHighlight ? .bold : .semibold)
                .foregroundStyle(isHighlight ? .primary : .secondary)
        }
    }
}

#Preview {
    let calculator = TipCalculator()
    calculator.billAmount = 100.00
    calculator.tipPercentage = 18
    calculator.splitCount = 4
    
    return ResultsView(calculator: calculator)
        .padding()
}
