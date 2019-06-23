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
        guard let sourceImage = CIImage(image: inputImage) else { return }
        guard let outputImage = filter.outputImage else { return }
        guard let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        filter.setValue(5.0, forKey: kCIInputImageKey)
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        let processImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        completion(processImage)
    }
}
