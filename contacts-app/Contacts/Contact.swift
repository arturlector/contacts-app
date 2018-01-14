//
//  Contact.swift
//  contacts-app
//
//  Created by Arthur on 14/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Contact {
    
    var contactID:      String? = nil
    var firstName:      String? = nil
    var lastName:       String? = nil
    var phoneNumber:    String? = nil
    var streetAddress1: String? = nil
    var streetAddress2: String? = nil
    var city:           String? = nil
    var state:          String? = nil
    var zipCode:        String? = nil
    
    init(json: JSON) {
        
        self.contactID = json["contactID"].stringValue
        self.firstName = json["firstName"].stringValue
        self.lastName = json["lastName"].stringValue
        self.phoneNumber = json["phoneNumber"].stringValue
        self.streetAddress1 = json["streetAddress1"].stringValue
        self.streetAddress2 = json["streetAddress2"].stringValue
        self.city = json["city"].stringValue
        self.state = json["state"].stringValue
        self.zipCode = json["zipCode"].stringValue
    }
}
