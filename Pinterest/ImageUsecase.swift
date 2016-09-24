//
//  ImageUsecase.swift
//  Pinterest
//
//  Created by Oka Yuya on 2016/09/24.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

import UIKit

protocol GetAnimalUsecase {
    func loadAnimalData(dataSource: NSArray)
    func laodAnimalNoData()
}

class ImageUsecase: NSObject {
    
    private let getModel = ImageGetModel()
    var usecase: GetAnimalUsecase!
    
    func request() {
        getModel.delegate = self
        getModel.requestAnimalWithData()
    }
}


extension ImageUsecase: RequestGetDelegate {
    func callback(dataSource: NSArray) {
        if dataSource.count > 0 {
            self.usecase?.loadAnimalData(dataSource)
        } else {
            self.usecase?.laodAnimalNoData()
        }
    }
}