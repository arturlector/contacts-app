//
//  ContactsDatasource.swift
//  contacts-app
//
//  Created by Arthur on 14/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import LBTAComponents
import SwiftyJSON

class ContactCell: DatasourceCell {
   
    override var datasourceItem: Any? {
        didSet {
            guard let contact = datasourceItem as? Contact else { return }
            
            nameLabel.text = (contact.firstName != nil ? contact.firstName! : "") + " " + (contact.lastName != nil ? contact.lastName! : "")
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setupViews() {
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
}

class ContactsDatasource: Datasource {

    var contacts: [Contact] = []
    
    init(json: JSON) {
        
        print(json["data"]["items"][0])
        
        let contactsJsonArray = json["data"]["items"]
        
        for contactJson in contactsJsonArray {
            let contact = Contact(json: contactJson.1)
            contacts.append(contact)
        }
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return contacts[indexPath.row]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return contacts.count
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ContactCell.self]
    }
}
