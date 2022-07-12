//
//  ContactDetailViewController.swift
//  ContactData
//
//  Created by Marta Kalichynska on 10.02.2022.
//

import UIKit
import CoreData

class ContactDetailViewController: UIViewController {
    
    var contact: NSManagedObject? = nil
    var isDeleted: Bool = false
    var indexPath: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = contact?.value(forKey: "name") as? String
        lastNameLabel.text = contact?.value(forKey: "lastName") as? String
        phoneLabel.text = contact?.value(forKey: "phoneNumber") as? String
        emailLabel.text = contact?.value(forKey: "email") as? String
        heightLabel.text = contact?.value(forKey: "height") as? String
        birthdayLabel.text = contact?.value(forKey: "birthday") as? String
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
    @IBAction func deleteContact(_ sender: Any) {
        isDeleted = true
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
    
    //navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            guard let viewController = segue.destination as? AddContactViewController else { return }
            viewController.titleText = "Edit Contact"
            viewController.contact = contact
            viewController.indexPathForContact = self.indexPath!
         }
    }
}
