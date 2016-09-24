//
//  ImageGetModelTest.swift
//  Pinterest
//
//  Created by Oka Yuya on 2016/09/24.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

import XCTest
@testable import Pinterest

class ImageGetModelTest: XCTestCase {
    
    let getModel = ImageGetModel()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParseWithAnimalDictionary() {
        getModel.delegate = self
        getModel.requestAnimalWithData()
    }
}


extension ImageGetModelTest: RequestGetDelegate {
    func callback(dataSource: NSArray) {
        XCTAssertTrue(dataSource.isKindOfClass(NSArray))
        XCTAssertTrue(dataSource[0].isKindOfClass(ImageModel))
        
        if dataSource.count > 0 {
            XCTAssertNotNil(dataSource)
            XCTAssertEqual(dataSource[0].caption, "リス")
            XCTAssertEqual(dataSource[0].comment, "リス（栗鼠）は、ネズミ目(齧歯目)リス科に属する動物の総称である。")
            XCTAssertEqual(dataSource[0].image, "01")
        } else {
            XCTAssertNil(dataSource)
        }
        
    }
}