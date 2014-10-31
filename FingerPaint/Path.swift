//
//  Path.swift
//  FingerPaint
//
//  Created by 朱里达 on 14/10/31.
//  Copyright (c) 2014年 zld. All rights reserved.
//

import UIKit

class Path:NSObject {
    var points:[CGPoint] = []
    let color:CGColor
    
    init(color: CGColor) {
        self.color = color
    }
    
    func add(point: CGPoint){
        points.append(point)
    }
}
