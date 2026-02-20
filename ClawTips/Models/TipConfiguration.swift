//
//  TipConfiguration.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import Foundation

/// App configuration and constants
struct TipConfiguration {
    /// Quick-select tip percentage options
    let quickTipOptions: [Int] = [15, 18, 20]
    
    /// Minimum tip percentage allowed
    let minTipPercentage: Int = 0
    
    /// Maximum tip percentage allowed
    let maxTipPercentage: Int = 30
    
    /// Minimum split count
    let minSplitCount: Int = 1
    
    /// Maximum split count
    let maxSplitCount: Int = 20
}
