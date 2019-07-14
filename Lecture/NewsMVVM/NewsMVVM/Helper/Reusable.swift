//
//  Reusable.swift
//  NewsMVVM
//
//  Created by hyeri kim on 14/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

protocol Reusable: class {}

extension Reusable where Self: UITableViewCell {
    static var cellReusable: String {
        return "Cell"
    }
}
