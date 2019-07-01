//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by hyeri kim on 30/06/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ToDoTableViewCell: Reusable {}
