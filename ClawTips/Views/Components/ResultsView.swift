//
//  ResultsView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI
import Combine
import UIKit

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
                
                // Payment Method Buttons
                VStack(spacing: 8) {
                    Text("Send Payment")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 12) {
                        ForEach(PaymentMethod.allCases, id: \.self) { method in
                            PaymentButton(
                                method: method,
                                isEnabled: method.isAvailable,
                                action: {
                                    handleSendPayment(method: method)
                                }
                            )
                        }
                    }
                }
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
        .alert(
            paymentCoordinator.errorMessage?.contains("Zelle") == true ? "Send via Zelle" : "Payment Notice",
            isPresented: .constant(paymentCoordinator.errorMessage != nil)
        ) {
            Button("OK") {
                paymentCoordinator.errorMessage = nil
            }
        } message: {
            if let error = paymentCoordinator.errorMessage {
                Text(error)
            }
        }
    }
    
    private func handleSendPayment(method: PaymentMethod) {
        let amount = calculator.result.amountPerPerson
        let message = "Your share from our meal"
        paymentCoordinator.sendPayment(amount: amount, message: message, method: method)
    }
}

// MARK: - Payment Button Component

struct PaymentButton: View {
    let method: PaymentMethod
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: method.iconName)
                    .font(.system(size: 28))
                    .foregroundStyle(isEnabled ? .white : .gray)
                
                Text(method.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(isEnabled ? .white : .gray)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
            .background(
                isEnabled
                    ? method.brandColor
                    : Color.gray.opacity(0.3)
            )
            .cornerRadius(12)
        }
        .disabled(!isEnabled)
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
