//
//  ContactsViewController.swift
//  ContactData
//
//  Created by Marta Kalichynska on 09.02.2022.
//

import UIKit

class ContactsViewController: UITableViewController {

    var contacts: [Contact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //self.navigationController?.pushViewController(AddContactViewController(), animated: true)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.phoneNumber
        return cell
    }
    // MARK: - Navigation
    
    //Unwind segue
    @IBAction  func unwindToContactList(segue: UIStoryboardSegue) {
        guard let viewController = segue.source as?  AddContactViewController else { return }
        guard  let name = viewController.nameTextField.text, let phoneNumber = viewController.phoneNumberTextField.text else { return }
        let contact = Contact(name: name, phoneNumber: phoneNumber)
        contacts.append(contact)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "contactDetailSegue" {
            guard let viewController = segue.destination as? ContactDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let contact = contacts[indexPath.row]
            viewController.contact = contact
        }
    }

}
