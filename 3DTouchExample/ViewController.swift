//
//  ViewController.swift
//  3DTouchExample
//
//  Created by Taras Chernyshenko on 6/30/17.
//  Copyright © 2017 Taras Chernyshenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var coverView: UIView?
    @IBOutlet private weak var selectedImageView: UIImageView?
    
    private var images: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        for i in 1 ... 8 {
            self.images.append(UIImage(named: "image_\(i)")!)
        }
        self.coverView?.isHidden = true
        self.selectedImageView?.isHidden = true
        let gesture = ForceTouchGestureRecognizer(target: self,
            action: #selector(imagePressed(sender:)))
        
        self.view.addGestureRecognizer(gesture)
    }
    
    func imagePressed(sender: ForceTouchGestureRecognizer) {
        
        let location = sender.location(in: self.view)
        
        guard let indexPath = collectionView?.indexPathForItem(
            at: location) else { return }

       let image = self.images[indexPath.row]
        
        switch sender.state {
        case .changed:
            if sender.isForceTouch {
                self.coverView?.isHidden = false
                self.selectedImageView?.isHidden = false
                self.selectedImageView?.image = image
            }
            
        case .ended:
            print("force: \(sender.forceValue)")
            if sender.isForceTouch {
                self.coverView?.isHidden = true
                self.selectedImageView?.isHidden = true
                self.selectedImageView?.image = nil
            } else {
                //TODO: handle selecting items of UICollectionView here,
                //you can refer to this SO question for more info: https://stackoverflow.com/questions/42372609/collectionview-didnt-call-didselectitematindexpath-when-superview-has-gesture
                print("Did select row at indexPath: \(indexPath)")
                self.collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
            }
            
        default: break
        }
    }
    
    //MARK: UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CollectionViewCellIdentifier",
            for: indexPath) as? CollectionViewCell else {
                assertionFailure("cell didn't init")
                return UICollectionViewCell()
        }
        cell.imageView?.image = self.images[indexPath.row]
        return cell
    }
    
    //MARK: UICollectionViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2,
                      height: UIScreen.main.bounds.width / 2)
    }
}

