//
//  AddContactViewController.swift
//  ContactData
//
//  Created by Marta Kalichynska on 09.02.2022.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    @IBAction func saveAndClose(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        nameTextField.text = nil
        phoneNumberTextField.text = nil
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
    
}
