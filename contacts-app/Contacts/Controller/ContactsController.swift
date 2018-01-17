//
//  ContactsController.swift
//  contacts-app
//
//  Created by Arthur on 14/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import LBTAComponents
import SwiftyJSON
import UIKit

class ContactsController: DatasourceController {
    
    var contactsDatasource: ContactsDatasource? = nil
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
        
        setupNavigationBar()
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchContactsFromDB()
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //MARK: - Navigation Bar
    func setupNavigationBar() {
    
        self.title = "Contacts"
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addContact(sender:)))
        
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    //MARK: - Actions
    func configureData() {
        
        typealias ContactType = (count: Int?, contacts: [MOContact]?)
        let contactType: (count: Int?, contacts: [MOContact]?) = ContactStore.sharedInstance.checkContactsCount()
        
        if contactType.count! > 0 {
            fetchContactsFromDB()
        } else {
            fetchContactsFromJson()
        }
    }
    
    func fetchContactsFromDB() {
        let contacts = ContactStore.sharedInstance.fetchAllContacts()
        contactsDatasource = ContactsDatasource(contacts: contacts!)
        self.datasource = contactsDatasource
    }
    
    func fetchContactsFromJson() {
        let path: String = Bundle.main.path(forResource: "contacts", ofType: "json")!
        let jsonData = NSData(contentsOfFile:path)
        
        do {
            let json = try JSON(data: jsonData! as Data)
            contactsDatasource = ContactsDatasource(json: json)
            self.datasource = contactsDatasource
        }
        catch {}
    }
    
    func deleteContactFromScreen(contact: MOContact) {

        if contact.contactID != nil {
            ContactStore.sharedInstance.deleteContact(contactID: contact.contactID!)
        }

        var contactsArray = contactsDatasource?.contacts
        let index = contactsArray?.index(of: contact)
        contactsArray?.remove(at: index!)
        contactsDatasource?.contacts = contactsArray!
        collectionView?.reloadData()
    }
    
    //MARK: - Events
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contact = contactsDatasource!.contacts[indexPath.row]
        showEditContact(contact: contact)
    }
    
    @objc func addContact(sender: UIBarButtonItem) {
        showNewContact()
    }
    
    //MARK: - Navigation
    
    func showNewContact() {
        let newContactController: EditContactController = EditContactController()
        self.navigationController?.pushViewController(newContactController, animated: true)
        
        newContactController.contact = ContactStore.sharedInstance.createEmptyContact()
    }
    
    func showEditContact(contact: MOContact) {
        let editContactController: EditContactController = EditContactController()
        self.navigationController?.pushViewController(editContactController, animated: true)
        editContactController.contact = contact
    }
}
