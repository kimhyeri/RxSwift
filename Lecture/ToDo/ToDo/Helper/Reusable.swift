//
//  Reusable.swift
//  ToDo
//
//  Created by hyeri kim on 01/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

protocol Reusable: class {}

extension Reusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return "Cell"
    }
}
