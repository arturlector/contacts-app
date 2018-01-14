//
//  EditContactDatasource.swift
//  contacts-app
//
//  Created by Arthur on 14/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import LBTAComponents

class DetailCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let name = datasourceItem as? String else { return }
            
            nameLabel.text = name
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

class EditContactDatasource: Datasource {
    
    var contacts = ["contact1", "contact2", "contact3"]
    
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
