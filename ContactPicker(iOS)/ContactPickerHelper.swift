//
//  ContactPicker.swift
//  ContactPicker(iOS)
//
//  Created by Oladeji Muhammed  on 12/9/24.
//


//
//  ContactPicker.swift
//  iosApp
//
//  Created by Oladeji Muhammed  on 12/8/24.
//  Copyright © 2024 orgName. All rights reserved.
//


import SwiftUI
import ContactsUI

public struct ContactPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var onSelect: (CNContact) -> Void

    public func makeUIViewController(context: Context) -> some UIViewController {
        let navController = UINavigationController()
        let pickerVC = CNContactPickerViewController()
        pickerVC.delegate = context.coordinator
        navController.pushViewController(pickerVC, animated: false)
        navController.isNavigationBarHidden = true
        return navController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
  
    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPicker

        init(parent: ContactPicker) {
            self.parent = parent
        }

        public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

        }

        public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.onSelect(contact)
        }
    }
}

struct ContactPickerViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)?
    var onSelect: ((CNContact) -> Void)

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                ContactPicker(isPresented: $isPresented, onSelect: onSelect)
            }
    }
}


func formatContactPhoneNumber(contact: CNContact) -> String {
    var contactNumber = ""
    for phoneNumber in contact.phoneNumbers {
        let label = CNLabeledValue<NSString>.localizedString(forLabel: phoneNumber.label ?? "Unknown")
        let number = phoneNumber.value.stringValue
        contactNumber = number
        print("Label: \(label), Number: \(number)")
    }
    return contactNumber
}


//public extension View {
//    func contactPicker(isPresented: Binding<Bool>, onDismiss: (() -> Void)?, onSelect: @escaping ((CNContact) -> Void)) -> some View {
//        modifier(ContactPickerViewModifier(isPresented: isPresented, onDismiss: onDismiss, onSelect: onSelect))
//    }
//}
