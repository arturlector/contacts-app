//
//  EditContactController.swift
//  contacts-app
//
//  Created by Arthur on 14/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import LBTAComponents

class EditContactController: UIViewController, UITextFieldDelegate {
    
    var contact: Contact? = nil
    
    lazy var contactDataArray: [(String, String?)] = [
        ("First Name", contact?.firstName),
        ("Last Name", contact!.lastName),
        ("Phone", contact!.phoneNumber),
        ("Address 1", contact!.streetAddress1),
        ("Address 2", contact!.streetAddress2),
        ("City", contact!.city),
        ("State", contact!.state),
        ("Zip code", contact!.zipCode)
    ]
    
    var containerScrollView: UIScrollView? = nil
    var containerTextField: UITextField? = nil
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        generateViews()
    }
    
    //MARK: - Navigation Bar
    
    func setupNavigationBar() {
        
        let editBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(editContact(sender:)))
        
        self.navigationItem.rightBarButtonItem = editBarButton
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
        view.addSubview(textField)
        
        label.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 0)
        textField.anchor(view.topAnchor, left: label.rightAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 0)
        
        return (view, textField)
    }
    
    //MARK: - Events
    
    @objc func editContact(sender: UIBarButtonItem) {
        print("editContact")
    }
}
