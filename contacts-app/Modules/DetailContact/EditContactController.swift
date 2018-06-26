//
//  EditContactController.swift
//  contacts-app
//
//  Created by Arthur on 14/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import LBTAComponents

class EditContactController: UIViewController, UITextFieldDelegate {
    
    enum ContactField: Int {
        case FirstName  = 0
        case LastName   = 1
        case Phone      = 2
        case Address1   = 3
        case Address2   = 4
        case City       = 5
        case State      = 6
        case ZipCode    = 7
        
        static var count: Int { return ContactField.ZipCode.hashValue + 1}
    }
    
    var contact: MOContact? = nil
    
    lazy var contactDataArray: [(String, String?)] = [
        ("First Name", contact?.firstName),
        ("Last Name", contact?.lastName),
        ("Phone", contact?.phoneNumber),
        ("Address 1", contact?.streetAddress1),
        ("Address 2", contact?.streetAddress2),
        ("City", contact?.city),
        ("State", contact?.state),
        ("Zip code", contact?.zipCode)
    ]
    
    var containerScrollView: UIScrollView? = nil
    var containerTextField: UITextField? = nil
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
        
        
        setupNavigationBar()
        generateViews()
    }
    
    //MARK: - Navigation Bar
    
    func setupNavigationBar() {
        
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveContact(sender:)))
        self.navigationItem.rightBarButtonItem = saveBarButton
        
        let backBarButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backToContacts(sender:)))
        
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    //MARK: - Configure
    
    func generateViews() {
        containerScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 1.1))
        view.addSubview(containerScrollView!)
        var before = UIView()
        containerScrollView?.addSubview(before)
        before.anchor(containerScrollView?.topAnchor, left: containerScrollView?.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: containerScrollView!.frame.width, heightConstant: 1)
        
        for (index, data) in contactDataArray.enumerated() {
            if let item = data.1 {
                let item = EditContactController.createItem(title: data.0, value: item)
                containerTextField = item.textField
                containerTextField!.tag = index
                containerTextField?.delegate = self
                
                containerScrollView?.addSubview(item.view)
                item.view.anchor(before.bottomAnchor, left: containerScrollView!.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: containerScrollView!.frame.width, heightConstant: 60)
                
                let separator = UIView()
                containerScrollView?.addSubview(separator)
                separator.anchor(item.view.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: containerScrollView!.frame.width, heightConstant: 1)
                separator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
                
                before = item.view
            }
        }
    }

    static func createItem(title: String, value: String) -> (view: UIView, textField: UITextField) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = title
        view.addSubview(label)
        
        let textField = UITextField()
        textField.text = value
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        //textField.layer.cornerRadius = 6
        view.addSubview(textField)
        
        label.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 0)
        textField.anchor(view.topAnchor, left: label.rightAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2 - 40, heightConstant: 0)
        
        return (view, textField)
    }
    
    //MARK: UITextFieldDelegate

    func textFieldDidEndEditing(_ textField: UITextField) {

        if let contactField = ContactField(rawValue: textField.tag) {
            
            switch contactField {
                
            case .FirstName:
                contact?.firstName = textField.text
            case .LastName:
                contact?.lastName = textField.text
            case .Phone:
                contact?.phoneNumber = textField.text
            case .Address1:
                contact?.streetAddress1 = textField.text
            case .Address2:
                contact?.streetAddress2 = textField.text
            case .City:
                contact?.city = textField.text
            case .State:
                contact?.state = textField.text
            case .ZipCode:
                contact?.zipCode = textField.text
            }
        }
    }
    
    //MARK: - Events
    
    @objc func saveContact(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        ContactStore.sharedInstance.saveContext()
    }
    
    @objc func backToContacts(sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
    }
}
