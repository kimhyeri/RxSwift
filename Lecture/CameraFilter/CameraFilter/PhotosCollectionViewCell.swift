//
//  PhotosCollectionViewCell.swift
//  CameraFilter
//
//  Created by hyeri kim on 23/06/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
}

extension PhotosCollectionViewCell: CellReusable {}
