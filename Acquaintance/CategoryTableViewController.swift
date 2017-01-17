//
//  CategoryTableViewController.swift
//  Acquaintance
//
//  Created by MacBook Pro  on 2016/12/1.
//  Copyright © 2016年 yucong shen. All rights reserved.
//
protocol Category{
    func tansferCategory(category:String)
}
import UIKit

class CategoryTableViewController: UITableViewController {
    var categoryArray = ["classmates", "colleagues", "teachers", "clients", "dentists"]
    
    var delegate : Category?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.categoryArray.count
    }
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        let dict=self.channelArray[indexPath.row] as! Dictionary<String,Any>
//        let channel:AnyObject=dict["channel_id"] as AnyObject
//        let channelID = "\(channel)"
//        print(channelID + "........")
//        self.delegate?.didChannelChange(channelID: channelID)
        let category = self.categoryArray[indexPath.row]
        print(category)
        self.delegate?.tansferCategory(category: category)
        self.dismiss(animated: true, completion: nil)
        //let dict=self.categoryArray[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorysCell", for: indexPath)
        cell.textLabel?.text=self.categoryArray[indexPath.row]
        // Configure the cell...

        return cell
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
