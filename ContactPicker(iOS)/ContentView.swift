//
//  ContentView.swift
//  ContactPicker(iOS)
//
//  Created by Oladeji Muhammed  on 12/9/24.
//

import SwiftUI
import Contacts

struct ContentView: View {
    @State var isPresented: Bool = false
    @State var phoneNumber: String = ""
    let contact = CNContact()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                isPresented.toggle()
                //                var onSelect: ((CNContact) -> Void)
                
            }
            .onAppear {
                isPresented.toggle()
            }
            .modifier(ContactPickerViewModifier(isPresented: $isPresented, onSelect: { contact in
                phoneNumber = formatContactPhoneNumber(contact: contact)
                print(phoneNumber)
            })
            )
    }
}

#Preview {
    ContentView()
}
