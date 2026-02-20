//
//  MessageComposerView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI
import MessageUI

/// SwiftUI wrapper for MFMessageComposeViewController
struct MessageComposerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    let composer: MFMessageComposeViewController
    let delegate: MFMessageComposeViewControllerDelegate
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        composer.messageComposeDelegate = delegate
        return composer
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
        // No updates needed
    }
}
