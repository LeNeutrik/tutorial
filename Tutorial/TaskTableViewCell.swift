//
//  TaskTableViewCell.swift
//  Tutorial
//
//  Created by Michael on 22.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameButtonOutlet: UIButton!
    @IBAction func nameButtonAction(sender: AnyObject) {
    }
    @IBOutlet weak var doneImageViewOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
