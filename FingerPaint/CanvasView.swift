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
    var currentColor :CGColor = UIColor.blackColor().CGColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var paths: [Path] = []
    var path: Path?
    var isDrawing: Bool = true
    var selectedButtonTag = -1
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        println(context)
        
        CGContextSetLineWidth(context, 2.0);
        
        CGContextBeginPath(context)
        
        var preX = zigzag[0].0, preY = zigzag[0].1
        for (x,y) in zigzag {
            CGContextMoveToPoint(context, CGFloat(preX), CGFloat(preY))
            CGContextAddLineToPoint(context, CGFloat(x), CGFloat(y))
            preX = x
            preY = y
        }
        CGContextSetStrokeColorWithColor(context, currentColor)
        
        CGContextStrokePath(context)
        
        if paths.count != 0 {
            for onePath in paths {
                var points :[CGPoint]=onePath.points
                var preX = points[0].x, preY = points[0].y
                for point in points {
                    CGContextMoveToPoint(context, CGFloat(preX), CGFloat(preY))
                    CGContextAddLineToPoint(context, point.x, point.y)
                    preX = point.x
                    preY = point.y
                }
                CGContextSetStrokeColorWithColor(context, onePath.color)
                CGContextStrokePath(context)
            }
        }

    }
    
    
    func setButtonShadow(tag: Int){
        for i in 0...4 {
            if tag == i {
                self.viewWithTag(i)!.layer.shadowRadius = 3
            } else {
                self.viewWithTag(i)!.layer.shadowRadius = 0
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        paths.append(Path(color: currentColor))
        paths[paths.count - 1].add(point)
        println("Touch: \(point)")
        isDrawing = true
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        paths[paths.count - 1].add(point)
        isDrawing = true
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        paths[paths.count - 1].add(point)
        isDrawing = false
        setNeedsDisplay()
        
    }
    
    func setupClearButton() {
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRect(x: 267, y: 518, width: 37, height: 30)
        button.setTitle("Clear", forState: UIControlState.Normal)
        button.addTarget(nil, action: "clearCanvas", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
    }
    
    func clearCanvas() {
        paths = []
        path = nil
        setNeedsDisplay()
        println("Cleared")
    }

}
