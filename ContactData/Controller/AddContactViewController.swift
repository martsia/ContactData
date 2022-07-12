//
//  AddContactViewController.swift
//  ContactData
//
//  Created by Marta Kalichynska on 09.02.2022.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {
    
    var titleText = "New Contact"
    var contact: NSManagedObject? = nil
    var indexPathForContact: IndexPath? = nil

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
        if let contact = self.contact {
            nameTextField.text = contact.value(forKey: "name") as? String
            surnameTextField.text = contact.value(forKey: "lastName") as? String
            phoneNumberTextField.text = contact.value(forKey: "phoneNumber") as? String
            emailTextField.text = contact.value(forKey: "email") as? String
            heightTextField.text = contact.value(forKey: "height") as? String
            birthdayTextField.text = contact.value(forKey: "birthday") as? String
        }
        createDataPicker()
        createDoneOnToolbar()
    }
    
    @IBAction func addPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func createDoneOnToolbar() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //barButton
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        nameTextField.inputAccessoryView = toolbar
        surnameTextField.inputAccessoryView = toolbar
        birthdayTextField.inputAccessoryView = toolbar
        phoneNumberTextField.inputAccessoryView = toolbar
        emailTextField.inputAccessoryView = toolbar
        heightTextField.inputAccessoryView = toolbar
    }
    
    func createDataPicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        birthdayTextField.inputView = datePicker
        //birthdayTextField.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        birthdayTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }

    
    @objc func donePressed() {
        self.view.endEditing(true)
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

extension AddContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("info")
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
