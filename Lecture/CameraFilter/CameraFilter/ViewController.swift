//
//  ViewController.swift
//  CameraFilter
//
//  Created by hyeri kim on 23/06/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationC = segue.destination as? UINavigationController, 
            let photosVC = navigationC.viewControllers.first as? PhotosCollectionViewController else  {
                return
        }
        
        photosVC.selectedPhoto.subscribe(onNext: { [weak self] photo in 
            guard let self = self else { return } 
            self.photoImageView.image = photo
        }).disposed(by: disposeBag)
        
    }
        
}

