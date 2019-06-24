//
//  FilterService.swift
//  CameraFilter
//
//  Created by hyeri kim on 23/06/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
    
    private var context: CIContext
    private let filterName = CIFilter(name: "CISepiaTone")
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create({ observer in
            self.applyFilter(to: inputImage, completion: { (filteredImage) in
                observer.onNext(filteredImage)
            })
            return Disposables.create()
        })
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        guard let filter = filterName else { return }
        filter.setValue(5.0, forKey: kCIInputImageKey)
        
        guard let sourceImage = CIImage(image: inputImage) else { return }
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        if let outerImage = filter.outputImage, 
            let cgImg = self.context.createCGImage(outerImage, from: outerImage.extent) {
            let processImage = UIImage(cgImage: cgImg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            completion(processImage)
        }
    }
}
