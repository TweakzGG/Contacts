//
//  ContactManager.swift
//  Contacts
//
//  Created by Jackson Barnes on 9/10/21.
//

import Foundation

class ContactManager{
    static let shared = ContactManager()
    var contacts: [Contact] = []
    private var fileURL: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("contacts")
        url.appendPathExtension("json")
        return url
    }
    init(){
        loadContacts()
    }
    
    //C
    func createContact(name: String, email: String, phone: Int){
        let newContact = Contact(name: name, email: email, phone: phone)
        contacts.append(newContact)
        saveContacts()
    }
    
    //R
    func loadContacts(){
        do {
        let decoder = JSONDecoder()
        let data = try Data (contentsOf: fileURL)
        let contacts = try decoder.decode([Contact].self, from: data)
        self.contacts = contacts
        } catch {
            print(error)
        }
    }
    
    //U
    func update (contact: Contact, newName: String, newEmail: String, newPhone: Int) {
        contact.name = newName
        contact.email = newEmail
        contact.phone = newPhone
        saveContacts()
    }
    
    //D
    func delete(contact: Contact) {
        guard let index = contacts.firstIndex(of: contact) else { return }
        contacts.remove(at: index)
        saveContacts()
    }
    
    
    func saveContacts() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(contacts)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
}
