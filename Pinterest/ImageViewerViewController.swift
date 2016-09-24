//
//  ImageViewerViewController.swift
//  Pinterest
//
//  Created by Oka Yuya on 2016/09/24.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController {

    @IBOutlet weak var animalImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTappedClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
