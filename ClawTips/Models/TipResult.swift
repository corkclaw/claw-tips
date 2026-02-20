//
//  TipResult.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import Foundation

/// Result of a tip calculation
struct TipResult {
    let billAmount: Decimal
    let tipPercentage: Int
    let splitCount: Int
    
    /// Calculated tip amount
    var tipAmount: Decimal {
        billAmount * Decimal(tipPercentage) / 100
    }
    
    /// Total amount (bill + tip)
    var totalAmount: Decimal {
        billAmount + tipAmount
    }
    
    /// Amount per person after split
    var amountPerPerson: Decimal {
        totalAmount / Decimal(splitCount)
    }
    
    /// Total rounded up to nearest dollar
    var roundedTotal: Decimal {
        totalAmount.rounded(.up, scale: 0)
    }
}
