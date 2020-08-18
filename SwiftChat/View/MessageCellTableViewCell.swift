//
//  MessageCellTableViewCell.swift
//  SwiftChat
//
//  Created by Kishlay Chhajer on 2020-08-18.
//  Copyright © 2020 Kishlay Chhajer. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var youImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         messageView.layer.cornerRadius = messageView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
