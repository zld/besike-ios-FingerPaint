//
//  ViewController.swift
//  FingerPaint
//
//  Created by 朱里达 on 14/10/31.
//  Copyright (c) 2014年 zld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var canvasView:CanvasView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let canvasView = CanvasView(frame:CGRectMake(0, 0, view.frame.width, view.frame.height))
        self.canvasView = canvasView
        self.canvasView?.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(canvasView)
        self.canvasView?.drawRect(CGRectMake(100, 100, 100, 100))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

