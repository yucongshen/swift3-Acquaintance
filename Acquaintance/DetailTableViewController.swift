//
//  DetailTableViewController.swift
//  Acquaintance
//
//  Created by MacBook Pro  on 2016/11/24.
//  Copyright © 2016年 yucong shen. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Category{
    var person: PersonMO?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = person?.name
        if let photoData = person?.photo {
            photoImageView.image = UIImage(data: photoData as Data)
        } else {
            photoImageView.image = UIImage(named:"photoalbum")
        }
        notesTextView.text = person?.notes
        emailTextField.text = person?.email
        phoneTextField.text = person?.phone
        categoryTextField.text=person?.category
        navigationItem.title = "Details"
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if presentingViewController is UINavigationController {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        if nameTextField.text == nil || nameTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Invalid Data", message: "The name cannot be empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "SaveToList", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1, UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    func tansferCategory(category:String){
        categoryTextField.text=category
    }
    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showCategorys",
            let categoryController = segue.destination as? CategoryTableViewController {
            categoryController.delegate = self
            print("showcategory.......")
        }

        if segue.identifier == "SaveToList", let appDelegate = (UIApplication.shared.delegate as?
            AppDelegate) {
            let name = nameTextField.text!
            let photo = photoImageView.image
            let notes = notesTextView.text
            let email = emailTextField.text
            let phone = phoneTextField.text
            let category = categoryTextField.text
            if person == nil { // add a new entry
                self.person=appDelegate.addToContext(name: name, photo: photo, notes: notes, email: email, phone: phone, category: category)
//                self.person = appDelegate.addToContext(name: name, photo: photo, notes: notes, )
            } else { // updating the existing entry
            }
            if person == nil { // add a new entry
                person = appDelegate.addToContext(name: name, photo: photo, notes: notes, email: email! , phone: phone!, category: category!)
            } else { // update an existing entry
                appDelegate.updateToContext(person: person!, name: name, photo: photo, notes: notes, email: email, phone: phone, category: category)
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "SaveToList" {
//            if person == nil {
//                person = Person(nameTextField.text!)
//            } else {
//                person?.name = nameTextField.text!
//            }
//            person!.photo = photoImageView.image
//            person!.notes = notesTextView.text
//        }
    }

}
