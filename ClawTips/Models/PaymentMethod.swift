//
//  PaymentMethod.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI
import UIKit
import MessageUI

enum PaymentMethod: String, CaseIterable {
    case appleCash = "Apple Cash"
    case venmo = "Venmo"
    case zelle = "Zelle"
    
    /// Brand color for the payment method
    var brandColor: Color {
        switch self {
        case .appleCash:
            return Color.black
        case .venmo:
            return Color(red: 0.20, green: 0.60, blue: 0.86) // Venmo Blue: #3D95CE
        case .zelle:
            return Color(red: 0.38, green: 0.15, blue: 0.55) // Zelle Purple: #6D1ED4
        }
    }
    
    /// System icon or custom icon name
    var iconName: String {
        switch self {
        case .appleCash:
            return "applelogo"
        case .venmo:
            return "v.circle.fill"  // Using V as placeholder
        case .zelle:
            return "z.circle.fill"  // Using Z as placeholder
        }
    }
    
    /// Check if payment method is available on device
    var isAvailable: Bool {
        switch self {
        case .appleCash:
            return MFMessageComposeViewController.canSendText()
        case .venmo:
            return canOpenURL("venmo://")
        case .zelle:
            return canOpenURL("zelle://") // Or handle via web
        }
    }
    
    /// Deep link URL scheme
    func deepLinkURL(amount: Decimal, note: String) -> URL? {
        let formattedAmount = String(describing: amount)
        let encodedNote = note.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        switch self {
        case .appleCash:
            return nil // Handled via Messages
        case .venmo:
            // venmo://paycharge?txn=pay&amount=X&note=...
            return URL(string: "venmo://paycharge?txn=pay&amount=\(formattedAmount)&note=\(encodedNote)")
        case .zelle:
            // Zelle doesn't have a standard deep link, will use web fallback
            return nil
        }
    }
    
    private func canOpenURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
}
