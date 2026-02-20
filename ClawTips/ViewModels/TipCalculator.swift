//
//  TipCalculator.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import Foundation
import Observation

/// View model for tip calculation state
@Observable
class TipCalculator {
    // MARK: - Published State
    
    var billAmount: Decimal = 0
    var tipPercentage: Int = 18  // Default 18%
    var splitCount: Int = 1      // Default 1 person
    var roundUpEnabled: Bool = false
    
    // MARK: - Configuration
    
    let configuration = TipConfiguration()
    
    // MARK: - Computed Properties
    
    /// Current calculation result
    var result: TipResult {
        TipResult(
            billAmount: billAmount,
            tipPercentage: tipPercentage,
            splitCount: splitCount
        )
    }
    
    /// Formatted bill amount string
    var formattedBillAmount: String {
        formatCurrency(billAmount)
    }
    
    /// Formatted tip amount string
    var formattedTipAmount: String {
        formatCurrency(result.tipAmount)
    }
    
    /// Formatted total amount string
    var formattedTotalAmount: String {
        let total = roundUpEnabled ? result.roundedTotal : result.totalAmount
        return formatCurrency(total)
    }
    
    /// Formatted amount per person string
    var formattedAmountPerPerson: String {
        formatCurrency(result.amountPerPerson)
    }
    
    // MARK: - Methods
    
    /// Set tip percentage to a quick-select value
    func selectQuickTip(_ percentage: Int) {
        tipPercentage = percentage
    }
    
    /// Reset calculator to default state
    func reset() {
        billAmount = 0
        tipPercentage = 18
        splitCount = 1
        roundUpEnabled = false
    }
    
    // MARK: - Private Helpers
    
    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0.00"
    }
}
