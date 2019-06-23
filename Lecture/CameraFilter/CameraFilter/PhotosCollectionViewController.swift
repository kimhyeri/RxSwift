//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by hyeri kim on 23/06/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import RxSwift
import Photos

class PhotosCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()

    }

    func populatePhotos() {
        PHPhotoLibrary.requestAuthorization({ status in
            if status == .authorized {
                // access the photo from library
            }
        })
    }
    
}
