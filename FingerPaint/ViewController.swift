//
//  ViewController.swift
//  FingerPaint
//
//  Created by 朱里达 on 14/10/31.
//  Copyright (c) 2014年 zld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var canvasView:CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let canvasView = CanvasView(frame:CGRectMake(0, 0, view.frame.width, view.frame.height))
        self.canvasView = canvasView
        self.canvasView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(canvasView)
        self.setupColorPickers()
        self.canvasView.setupClearButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            self.canvasView.addSubview(button)
        }
        
    }
    
    func colorPickerTapped(button: UIButton){
        println("Tapped: \(button.backgroundColor)")
        self.canvasView.selectedButtonTag = button.tag
        self.canvasView.setButtonShadow(button.tag)
        self.canvasView.currentColor = button.backgroundColor!.CGColor
    }
    

}

