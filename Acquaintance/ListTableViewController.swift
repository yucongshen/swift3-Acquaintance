//
//  ListTableViewController.swift
//  Acquaintance
//
//  Created by MacBook Pro  on 2016/11/24.
//  Copyright © 2016年 yucong shen. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    var acqList = [PersonMO]()
    var acqNames = ["Ameir Al-Zoubi", "Bill Dudney", "Bob McCune", "Brent Simmons", "Cesare Rocchi", "Chad Sellers", "Conrad Stoll", "Daniel Pasco", "Jaimee Newberry", "James Dempsey", "Josh Abernathy", "Justin Miller", "Ken Auer", "Kevin Harwood", "Kyle Richter", "Manton Reece", "Marcus Zarra", "Mark Pospesel", "Matt Drance", "Michael Simmons", "Michele Titolo", "Michael Simmons", "Rene Cacheaux", "Rob Napier", "Scott McAlister", "Sean McMains"]

        override func viewDidLoad() {
        super.viewDidLoad()
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            if !FileManager().fileExists(atPath:PersonMO.StoreURL.path) {
                for name in acqNames {
                    let person = appDelegate.addToContext(name: name, photo: UIImage(named: name),notes: nil, email: "", phone: nil, category: nil)
                    acqList.append(person)
                }
            } else {
                if let fetchedList = appDelegate.fetchContext() {
                    acqList += fetchedList
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // #warning Incomplete implementation, return the number of rows
        return acqList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as!
        ListTableViewCell
        let person = acqList[indexPath.row]
        // Configure the cell...
        if let photoData = person.photo {
            cell.photoImageView.image = UIImage(data: photoData as Data)
        } else {
            cell.photoImageView.image = UIImage(named:"photoalbum")
        }
        cell.nameLabel.text = person.name
        cell.notesLabel.text = person.notes
        cell.phoneLabel.text=person.phone
        cell.emailLabel.text=person.email
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let person = acqList[indexPath.row]
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                appDelegate.deleteFromContext(person: person)
                acqList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
//        if editingStyle == .delete {
//            acqList.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            // Delete the row from the data source acqList.remove(at: indexPath.row) tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        if segue.identifier == "SaveToList",
            let detailViewController = segue.source as? DetailTableViewController, let person = detailViewController.person {
            if let selectedIndexPath = tableView.indexPathForSelectedRow { // Update an existing person.
                acqList[(selectedIndexPath as NSIndexPath).row] = person
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new person.
                let newIndexPath = IndexPath(row: acqList.count, section: 0)
                acqList.append(person)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }

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
        if segue.identifier == "ShowDetail",
            let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? DetailTableViewController {
            detailViewController.person = acqList[indexPath.row]
        }
        print("prepre")
            // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
