//
//  ContactPickerView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI
import ContactsUI

/// SwiftUI wrapper for CNContactPickerViewController
struct ContactPickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let onSelect: ([CNContact]) -> Void
    
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, onSelect: onSelect)
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        @Binding var isPresented: Bool
        let onSelect: ([CNContact]) -> Void
        
        init(isPresented: Binding<Bool>, onSelect: @escaping ([CNContact]) -> Void) {
            self._isPresented = isPresented
            self.onSelect = onSelect
        }
        
        // Single contact selected
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            onSelect([contact])
            isPresented = false
        }
        
        // Multiple contacts selected
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            onSelect(contacts)
            isPresented = false
        }
        
        // Cancelled
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            isPresented = false
        }
    }
}
