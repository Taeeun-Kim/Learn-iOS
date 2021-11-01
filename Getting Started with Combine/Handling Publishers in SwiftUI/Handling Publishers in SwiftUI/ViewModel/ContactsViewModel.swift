//
//  ContactsViewModel.swift
//  Handling Publishers in SwiftUI
//
//  Created by Taeeun Kim on 01.11.21.
//

import SwiftUI
import Combine

final class ContactsViewModel: ObservableObject {
    @Published private(set) var contacts = [Contact]()
    
    func add(contact: Contact) {
        contacts.append(contact)
    }
}
