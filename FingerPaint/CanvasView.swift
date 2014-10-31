//
//  CanvasView.swift
//  FingerPaint
//
//  Created by 朱里达 on 14/10/31.
//  Copyright (c) 2014年 zld. All rights reserved.
//

import UIKit

class CanvasView: UIView {

    let zigzag = [(100,100),
                  (100,150),(150,150),
                            (150,200)]
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, 2.0);
        
        CGContextBeginPath(context)
        var preX = zigzag[0].0, preY = zigzag[0].1
        for (x,y) in zigzag {
            CGContextMoveToPoint(context, CGFloat(preX), CGFloat(preY))
            CGContextAddLineToPoint(context, CGFloat(x), CGFloat(y))
            preX = x
            preY = y
        }
        
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        
        CGContextStrokePath(context)
    }

}
