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
    
    // Expose observable
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    private var images = [PHAsset]()

    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
        
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization({ [weak self] status in
            if status == .authorized {
                guard let self = self else { return }
                
                // Access the photo from library
                // Only image fetching
                
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                 options: nil
                )
                
                assets.enumerateObjects { (object, count, stop) in
                    self.images.append(object)
                }
                
                // Most recent image on the top
                self.images.reverse()
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()                    
                }
                
            } else if status == .denied {
                print("User denied")
            }
        })
    }
}

//MARK: CollectionView Datasource
extension PhotosCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        let targetSize = CGSize(width: 100, height: 100)
        manager.requestImage(for: asset,
                             targetSize: targetSize,
                             contentMode: .aspectFit,
                             options: nil) { image, _ in
                                DispatchQueue.main.async {
                                    cell.photoImageView.image = image
                                }
        }
        return cell
    }
}

//MARK: CollectionView Delegate
extension PhotosCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // PHAsset to Image
        let selectedAsset = self.images[indexPath.row]
        let targetSize = CGSize(width: 300, height: 300)
        
        // ThumbnailImage to BigImage
        PHImageManager.default().requestImage(for: selectedAsset,
                                              targetSize: targetSize,
                                              contentMode: .aspectFit,
                                              options: nil
        ) { [weak self] (image, info) in
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
