//
//  ContactsViewController.swift
//  ContactData
//
//  Created by Marta Kalichynska on 09.02.2022.
//

import UIKit
import CoreData

class ContactsViewController: UITableViewController {
    
    var contacts: [NSManagedObject] = []
    @IBOutlet weak var emptyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        tableView.reloadData()
        
        //self.navigationController?.pushViewController(AddContactViewController(), animated: true)
    }
    
    // MARK: - Data Source
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        do {
            contacts = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    func save(name: String, lastName: String, phoneNumber: String, email: String, height: String, birthday: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedObjectContext) else { return }
        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        contact.setValue(name, forKey: "name")
        contact.setValue(lastName, forKey: "lastName")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(email, forKey: "email")
        contact.setValue(height, forKey: "height")
        contact.setValue(birthday, forKey: "birthday")
        do {
            try managedObjectContext.save()
            self.contacts.append(contact)
        } catch let error as NSError {
            print("could not save \(error)")
        }
    }
    
    func update(indexPath: IndexPath, name: String, lastName: String, phoneNumber: String, email: String, height: String, birthday: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let contact = contacts[indexPath.row]
        contact.setValue(name, forKey: "name")
        contact.setValue(lastName, forKey: "lastName")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(email, forKey: "email")
        contact.setValue(height, forKey: "height")
        contact.setValue(birthday, forKey: "birthday")
        
        do {
            try managedObjectContext.save()
            contacts[indexPath.row] = contact
        } catch let error as NSError {
            print("could not save \(error)")
        }
    }
    
    func delete(_ contact: NSManagedObject, at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(contact)
        contacts.remove(at: indexPath.row)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.value(forKey: "name") as? String
        cell.detailTextLabel?.text = contact.value(forKey: "phoneNumber") as? String
        
        if contacts.isEmpty {
            emptyView.isHidden = false
            cell.isHidden = true
        }
        else {
            emptyView.isHidden = true
            cell.isHidden = false
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // share item at indexPath
        }
        delete.backgroundColor = UIColor.red
        share.backgroundColor = UIColor.blue
        return [delete, share]
    }
    // MARK: - Navigation
    //Unwind segue
    @IBAction  func unwindToContactList(segue: UIStoryboardSegue) {
        if let viewController = segue.source as?  AddContactViewController {
            guard  let name: String = viewController.nameTextField.text, let phoneNumber: String = viewController.phoneNumberTextField.text, let lastName: String = viewController.surnameTextField.text, let email: String = viewController.emailTextField.text, let height: String = viewController.heightTextField.text, let birthday: String = viewController.birthdayTextField.text else { return }
            if name != "" && lastName != "" && phoneNumber != "" && email != "" && height != "" && birthday != "" {
                if let indexPath = viewController.indexPathForContact {
                    update(indexPath: indexPath, name: name, lastName: lastName, phoneNumber: phoneNumber, email: email, height: height, birthday: birthday)
                } else {
                    save(name: name, lastName: lastName, phoneNumber: phoneNumber, email: email, height: height, birthday: birthday)
                }
            }
            tableView.reloadData()
        } else if let viewController = segue.source as? ContactDetailViewController {
            if viewController.isDeleted {
                guard let indexPath: IndexPath =  viewController.indexPath else { return }
                let contact = contacts[indexPath.row]
                delete(contact, at: indexPath)
                tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "contactDetailSegue" {
            guard let viewController = segue.destination as? ContactDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let contact = contacts[indexPath.row]
            viewController.contact = contact
            viewController.indexPath = indexPath
        }
    }
    
}
