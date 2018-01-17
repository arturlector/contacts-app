//
//  ContactStore.swift
//  contacts-app
//
//  Created by Arthur on 15/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import CoreData
import SwiftyJSON

class ContactStore: NSObject {
    
    static let sharedInstance = ContactStore()
    
    var context: NSManagedObjectContext? = nil

    override init() {
        super.init()
        context = persistentContainer.viewContext
    }
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "contacts_app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD
    
    func createContact(json: JSON) -> MOContact? {
        
        var contact: MOContact? = nil
       
        contact = MOContact(context: context!)
        
        contact?.contactID =     json["contactID"].stringValue
        contact?.firstName =     json["firstName"].stringValue
        contact?.lastName =      json["lastName"].stringValue
        contact?.phoneNumber =   json["streetAddress1"].stringValue
        contact?.state =         json["city"].stringValue
        contact?.city =          json["city"].stringValue
        contact?.zipCode =       json["zipCode"].stringValue
        
        saveContext()
        
        return contact
    }
    
    func createEmptyContact() -> MOContact? {
        
        let contact: MOContact? = MOContact(context: context!)
        
        contact?.contactID =     " "
        contact?.firstName =     " "
        contact?.lastName =      " "
        contact?.phoneNumber =   " "
        contact?.state =         " "
        contact?.city =          " "
        contact?.zipCode =       " "
        
        return contact
    }
    
    func fetchAllContacts() -> [MOContact]?  {
        
        context?.reset()
        
        var contacts:[MOContact]? = nil
        //var contact:MOContact? = nil
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MOContact")
        do {
            contacts = try context?.fetch(fetchRequest) as? [MOContact]
            for contact in contacts! {
                print(contact)
            }
        } catch { }
        
        return contacts
    }
    
    func checkContactsCount() -> (Int?, [MOContact]?) {
        var contacts:[MOContact]? = nil

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MOContact")
        do {
            contacts = try context?.fetch(fetchRequest) as? [MOContact]
            return (contacts?.count, contacts)
        } catch { }
        
        return (nil, nil)
    }
    
    func deleteAllContacts() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MOContact")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context?.execute(deleteRequest)
        } catch { }
        
        saveContext()
    }
    
    func updateContact(contactID: String) {
        
    }
    
    func deleteContact(contactID: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MOContact")
        let predicate = NSPredicate(format: "contactID == %@", contactID)
        
        fetchRequest.predicate = predicate
        
        var result : [MOContact]? = nil
        do {
            result = try context?.fetch(fetchRequest) as? [MOContact]
        } catch { }
        
        
        for object in result!{
            context?.delete(object)
        }
        saveContext()
    }
}
