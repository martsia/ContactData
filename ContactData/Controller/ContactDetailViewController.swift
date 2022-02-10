//
//  ContactDetailViewController.swift
//  ContactData
//
//  Created by Marta Kalichynska on 10.02.2022.
//

import UIKit

class ContactDetailViewController: UIViewController {
    var contact: Contact? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = contact?.name
        phoneLabel.text = contact?.phoneNumber
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "unwindToContacts", sender: self)
    }
}
