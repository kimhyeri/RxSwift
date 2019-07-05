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
    @IBOutlet weak var applyFilterButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationC = segue.destination as? UINavigationController, 
            let photosVC = navigationC.viewControllers.first as? PhotosCollectionViewController else { return }
        
        photosVC.selectedPhoto.subscribe(onNext: { [weak self] photo in 
            guard let self = self else { return } 
            
            DispatchQueue.main.async {
                self.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
        
    @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = self.photoImageView.image else { return }

        FilterService().applyFilter(to: sourceImage)
        .subscribe(onNext: { (filteredImage) in
            DispatchQueue.main.async {
                self.photoImageView.image = filteredImage
            }
        })
        .disposed(by: disposeBag)
    }
}

