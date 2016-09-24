//
//  ViewController.swift
//  Pinterest
//
//  Created by Oka Yuya on 2016/09/24.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let input = ImageUsecase()
    private var dataSource = [ImageModel]()
    
    var imageTransitioningDelegate: ImageTransitioningDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        input.usecase = self
        input.request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.setConfigure(dataSource[indexPath.row])
        return cell
    }
}


// MARK - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if imageTransitioningDelegate == nil {
            imageTransitioningDelegate = ImageTransitioningDelegate()
        }
        
        let viewController = UIStoryboard(name: "ImageViewer", bundle: nil).instantiateViewControllerWithIdentifier("ImageViewer")
            as! ImageViewerViewController
        
        //Pinterest風のトランジションをセットしています
        viewController.transitioningDelegate = imageTransitioningDelegate
        
        viewController.animalImageView.image = UIImage(named: dataSource[indexPath.row].image)
        presentViewController(viewController, animated: true, completion: nil)
    }
}

// MARK - UICollectionViewDelegateFlowLayout
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        var size = CGSizeZero
//        if size.width / size.height == 1.0 {
//            size = CGSize(width: 44, height: 44)
//        } else {
//            size = CGSize(width: 44, height: 88)
//        }
//        
//        return size
//    }
//}

// MARK - GetAnimalUsecase
extension ViewController: GetAnimalUsecase {
    func loadAnimalData(dataSource: NSArray) {
        self.dataSource = dataSource as! [ImageModel]
        collectionView.reloadData()
    }
    
    func laodAnimalNoData() {
        let alert: UIAlertController = UIAlertController(title: "タイトル",
                                                         message: "メッセージ",
                                                         preferredStyle: .Alert)
        
        let button = UIAlertAction(title: "OK",
                                   style: .Default,
                                   handler: nil)
        
        alert.addAction(button)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}