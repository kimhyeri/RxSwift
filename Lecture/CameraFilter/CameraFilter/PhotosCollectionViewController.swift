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

    // expose observable
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()

    }

    func populatePhotos() {
        PHPhotoLibrary.requestAuthorization({ [weak self] status in
            if status == .authorized {
                guard let self = self else { return }

                // access the photo from library
                // only image fetching
                
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self.images.append(object)
                }
                
                // most recent image on the top
                self.images.reverse()
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()                    
                }
            }
        })
    }
    
}

extension PhotosCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // PHAsset to Image
        let selectedAsset = self.images[indexPath.row]
        // ThumbnailImage to BigImage
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] (image, info) in
            guard let self = self else { return }
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            // if it is not thumbnail Image
        
            if !isDegradedImage {
                // actually get the image
                if let image = image {
                    self.selectedPhotoSubject.onNext(image)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
