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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .lightGray
        
        let path: String = Bundle.main.path(forResource: "contacts", ofType: "json")!
        let jsonData = NSData(contentsOfFile:path)
        
        do {
            let json = try JSON(data: jsonData! as Data)
            contactsDatasource = ContactsDatasource(json: json)
            self.datasource = contactsDatasource
            
            //collectionView?.reloadData()
        }
        catch {}
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc: EditContactController = EditContactController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.contact = contactsDatasource!.contacts[indexPath.row]
    }
}

