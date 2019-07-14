//
//  ArticleTableViewCell.swift
//  NewsMVVM
//
//  Created by hyeri kim on 12/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension ArticleTableViewCell: Reusable{}
