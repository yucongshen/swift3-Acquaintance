//
//  ListTableViewCell.swift
//  Acquaintance
//
//  Created by MacBook Pro  on 2016/11/24.
//  Copyright © 2016年 yucong shen. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func makePhone(_ sender: UIButton) {
        if let url=URL(string:"tel:\(phoneLabel.text ?? "")"){
            print(url)
            UIApplication.shared.open(url, options:[:], completionHandler: nil)
        }else{
            print("电话号码为空！")
        }
//        let url = URL(string:phoneLabel.text ?? "")
//        if url == nil{
//            print("电话号码为空！")
//         }else{
//            //print(url)
//            UIApplication.shared.open(url!, options:[:], completionHandler: nil)
//        }
    }
    @IBAction func sendEmail(_ sender: UIButton) {
        let eurl=emailLabel.text! as String
        //发送邮件
        var mailUrl:String = String()
        //mailUrl.append("mailto:30548842@qq.com?subject=test&body=<b>hello email</b>")
        mailUrl.append("mailto:\(eurl)?subject=test&body=<b>hello email</b>")
        print(mailUrl)
        let email = mailUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if let url:URL = URL(string: email!){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print(UIApplication.shared.canOpenURL(url))
        }else{
            print("邮箱地址为空！")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
