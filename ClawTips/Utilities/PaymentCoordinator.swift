//
//  PaymentCoordinator.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import Foundation
import Combine
import MessageUI
import Contacts
import ContactsUI
import SwiftUI

/// Coordinates payment sending via Apple Cash/Messages
class PaymentCoordinator: NSObject, ObservableObject {
    @Published var isShowingContactPicker = false
    @Published var isShowingMessageComposer = false
    @Published var selectedContacts: [CNContact] = []
    @Published var errorMessage: String?
    
    private var pendingAmount: Decimal = 0
    private var pendingMessage: String = ""
    
    /// Check if Messages is available
    var canSendMessages: Bool {
        MFMessageComposeViewController.canSendText()
    }
    
    /// Initiate payment send flow
    func sendPayment(amount: Decimal, message: String) {
        guard canSendMessages else {
            errorMessage = "Messages is not available on this device"
            return
        }
        
        pendingAmount = amount
        pendingMessage = message
        isShowingContactPicker = true
    }
    
    /// Create message composer with payment details
    func createMessageComposer() -> MFMessageComposeViewController? {
        guard canSendMessages else { return nil }
        
        let composer = MFMessageComposeViewController()
        composer.messageComposeDelegate = self
        
        // Get phone numbers from selected contacts
        let recipients = selectedContacts.compactMap { contact -> String? in
            guard let phoneNumber = contact.phoneNumbers.first?.value else {
                return nil
            }
            return phoneNumber.stringValue
        }
        
        composer.recipients = recipients
        
        // Format message with amount
        let formattedAmount = formatCurrency(pendingAmount)
        composer.body = "\(pendingMessage): \(formattedAmount)"
        
        return composer
    }
    
    /// Handle contact selection from picker
    func didSelectContacts(_ contacts: [CNContact]) {
        selectedContacts = contacts
        isShowingContactPicker = false
        
        if !contacts.isEmpty {
            isShowingMessageComposer = true
        }
    }
    
    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0.00"
    }
}

// MARK: - MFMessageComposeViewControllerDelegate

extension PaymentCoordinator: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(
        _ controller: MFMessageComposeViewController,
        didFinishWith result: MessageComposeResult
    ) {
        isShowingMessageComposer = false
        
        switch result {
        case .cancelled:
            break
        case .sent:
            // Payment request sent successfully
            selectedContacts.removeAll()
        case .failed:
            errorMessage = "Failed to send payment request. Please try again."
        @unknown default:
            break
        }
    }
}
