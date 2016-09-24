//
//  ImageGetModel.swift
//  Pinterest
//
//  Created by Oka Yuya on 2016/09/24.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

import UIKit

protocol RequestGetDelegate {
    func callback(dataSource: NSArray)
}

class ImageGetModel: NSObject {

    var delegate: RequestGetDelegate!
    
    private var dataSource = [ImageModel]()
    
    func requestAnimalWithData() {
        let filePath = NSBundle.mainBundle().pathForResource("photos", ofType: "plist")
        if let filePath = filePath {
            let dictionary = NSDictionary(contentsOfFile: filePath)
            if let json = dictionary {
                dataSource = parseWithAnimalDictionary(json)
            }
        }
        
        delegate.callback(dataSource);
    }
    
    private func parseWithAnimalDictionary(json: NSDictionary) -> Array<ImageModel> {
        var arrays = [ImageModel]()
        
        for item in json["photos"] as! NSArray {
            let model = ImageModel()
            model.caption = item["caption"] as! String
            model.comment = item["comment"] as! String
            model.image = item["image"] as! String
            
            arrays.append(model)
        }
        
        return arrays
    }
    
}
