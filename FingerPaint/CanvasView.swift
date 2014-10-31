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
//        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        println(context)
//        println(self.frame.size)
        
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
        
        if path? != nil && isDrawing {
            var points :[CGPoint]=path!.points
            var preX = points[0].x, preY = points[0].y
            for point in points {
                CGContextMoveToPoint(context, CGFloat(preX), CGFloat(preY))
                CGContextAddLineToPoint(context, point.x, point.y)
                preX = point.x
                preY = point.y
            }
//            currentColor = path!.color
            CGContextSetStrokeColorWithColor(context, currentColor)
            CGContextStrokePath(context)
        }

        
//        CGContextSetStrokeColorWithColor(context, currentColor)
//        
//        CGContextStrokePath(context)
//        CGContextClearRect(context, self.bounds)
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
            button.enabled = true
            button.addTarget(self, action: "colorPickerTapped:", forControlEvents:UIControlEvents.TouchUpInside)

            button.layer.shadowColor = colors[i].CGColor
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowRadius = 0
            button.layer.shadowOpacity = 1
            
            self.addSubview(button)
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
    
    func colorPickerTapped(button: UIButton){
        println("Tapped: \(button.backgroundColor)")
        selectedButtonTag = button.tag
        setButtonShadow(button.tag)
        currentColor = button.backgroundColor!.CGColor
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        path = Path(color: currentColor)
        path!.add(point)
        println("Touch: \(point)")
        isDrawing = true
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        path!.add(point)
        isDrawing = true
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        path!.add(point)
        paths.append(path!)
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
