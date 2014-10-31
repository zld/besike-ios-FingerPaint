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
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        println("touch: \(point)")
    }
    
    func setupColorPickers() {
        let colors : [UIColor] = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            UIColor(red: 0x17/255.0, green: 0xA3/255.0, blue: 0xA5/255.0, alpha: 1),
            UIColor(red: 0x8D/255.0, green: 0xBF/255.0, blue: 0x67/255.0, alpha: 1),
            UIColor(red: 0xFC/255.0, green: 0xCB/255.0, blue: 0x5F/255.0, alpha: 1),
            UIColor(red: 0xFC/255.0, green: 0x6E/255.0, blue: 0x59/255.0, alpha: 1),
        ]
        
        let positions = [
            (33,43),(86,43),(138,43),(190,43),(242,43)
        ]
        
        let size = (44,44)
        
        var button:UIButton
        for i in 0...4 {
            button = UIButton(frame: CGRectMake(CGFloat(positions[i].0), CGFloat(positions[1].1), CGFloat(size.0), CGFloat(size.1)))
            button.backgroundColor = colors[i]
            button.tag = i
            self.addSubview(button)
        }
        
    }

}
