//
//  NibReusable.swift
//  CameraFilter
//
//  Created by hyeri kim on 26/06/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

protocol CellReusable: class {}

extension CellReusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return "Cell"
    }
}

extension CellReusable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return "Cell"
    }
}
