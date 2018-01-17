//
//  ContactCell.swift
//  contacts-app
//
//  Created by Arthur on 15/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import LBTAComponents
import UIKit

class ContactCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let contact = datasourceItem as? MOContact else { return }
            
            nameLabel.text = (contact.firstName != nil ? contact.firstName! : "") + " " + (contact.lastName != nil ? contact.lastName! : "")
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(deleteContact(sender:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life cycle
    
    override func setupViews() {
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(deleteButton)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        deleteButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 70, heightConstant: 40)

        let separator = UIView()
        addSubview(separator)
        separator.anchor(nameLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width, heightConstant: 1)
        separator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
    }
    
    //MARK: - Events
    
    @objc func deleteContact(sender: UIBarButtonItem) {
        print("deleteContact")
        
        guard let contact = datasourceItem as? MOContact else { return }
        
        let contactsController = parentController as! ContactsController
        contactsController.deleteContactFromScreen(contact: contact)
        
    }
}
