//
//  ContactsController.swift
//  contacts-app
//
//  Created by Arthur on 14/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import LBTAComponents
import SwiftyJSON

class ContactsController: DatasourceController {
    
    var contactsDatasource: ContactsDatasource? = nil
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .lightGray
        
        setupNavigationBar()
        
        loadContactsFromJsonFile()
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc: EditContactController = EditContactController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.contact = contactsDatasource!.contacts[indexPath.row]
    }
    
    //MARK: - Navigation Bar
    func setupNavigationBar() {
    
        self.title = "Contacts"
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addContact(sender:)))
        
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    //MARK: - Actions
    func loadContactsFromJsonFile() {
        let path: String = Bundle.main.path(forResource: "contacts", ofType: "json")!
        let jsonData = NSData(contentsOfFile:path)
    
        do {
        let json = try JSON(data: jsonData! as Data)
        contactsDatasource = ContactsDatasource(json: json)
        self.datasource = contactsDatasource
        }
        catch {}
    }
    
    //MARK: - Events
    @objc func addContact(sender: UIBarButtonItem) {
        print("addContact")
    }
}



