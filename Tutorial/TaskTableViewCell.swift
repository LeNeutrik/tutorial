//
//  TaskTableViewCell.swift
//  Tutorial
//
//  Created by Michael on 22.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var task: Task!{
        didSet{
            nameButtonOutlet.setTitle(task.name + " order:\(task.order)" , forState: .Normal)
        }
    }

    @IBOutlet weak var nameButtonOutlet: UIButton!{
        didSet {
            nameButtonOutlet.layer.cornerRadius = 6.0
            nameButtonOutlet.layer.borderColor = UIColor.lightGrayColor().CGColor
            nameButtonOutlet.layer.borderWidth = 1.0
            nameButtonOutlet.layer.backgroundColor =  UIColor(white: 0.99 , alpha: 1.0).CGColor
        }
    }
    
    @IBOutlet weak var doneImageViewOutlet: UIImageView!

    @IBAction func nameButtonAction(sender: AnyObject) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
