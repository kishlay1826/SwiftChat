//
//  ChatViewContoller.swift
//  SwiftChat
//
//  Created by Kishlay Chhajer on 2020-08-18.
//  Copyright © 2020 Kishlay Chhajer. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageText: UITextField!
    
    let db = Firestore.firestore()
    
    
      var messages: [Message] = []
      
      override func viewDidLoad() {
          super.viewDidLoad()
          tableView.dataSource = self
          title = "SwiftChat"
          navigationItem.hidesBackButton = true
          tableView.register(UINib(nibName: "MessageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
          loadMessages()
          
      }
    
    func loadMessages() {
           
           db.collection("messages")
               .order(by: "date")
               .addSnapshotListener { (querySnapshot, error) in
               
               self.messages = []
               
               if let e = error {
                   print(e)
               } else {
                   if let snapshotDocuments = querySnapshot?.documents {
                       for doc in snapshotDocuments {
                           let data = doc.data()
                           if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                               let newMessage = Message(sender: messageSender, body: messageBody)
                               self.messages.append(newMessage)
                               
                               DispatchQueue.main.async {
                                      self.tableView.reloadData()
                                   let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                   self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                               }
                           }
                       }
                   }
               }
           }
       }
       
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCellTableViewCell
        cell.messageText.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.meImage.isHidden = false
            cell.youImage.isHidden = true
            cell.messageView.backgroundColor = UIColor.systemGreen
            cell.messageText.textColor = UIColor.white
        } else {
            cell.meImage.isHidden = true
            cell.youImage.isHidden = false
            cell.messageView.backgroundColor = UIColor.systemGray2
            cell.messageText.textColor = UIColor.white
        }
        return cell
        }
    
    
    
    @IBAction func sendButton(_ sender: Any) {
        if let message = messageText.text, let sender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": sender,
                "body": message,
                "date": Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    DispatchQueue.main.async {
                         self.messageText.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        do {
                try Auth.auth().signOut()
                   navigationController?.popToRootViewController(animated: true)
               } catch let signOutError as NSError {
                 print (signOutError)
               }
           }
    }
    
    


