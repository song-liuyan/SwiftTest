//
//  MyPrompt.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/28.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit

class MyPrompt:NSObject {
    //相当于OC中的单例
    static let sharedInstance = MyPrompt()
    
    private let kFout = UIFont.systemFontOfSize(15)
    private let maxWidth = KScreenWidth-120
    
    private var bgButton:UIButton?
    private var fileLabel:UILabel?
    
    private override init() {
        bgButton = UIButton(frame: CGRectMake(0, 0, KScreenWidth, KScreenHeight))
        bgButton?.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        bgButton?.userInteractionEnabled = false
        bgButton?.hidden = true
        
        fileLabel = UILabel(frame: CGRectMake(0, 0, 100, 25))
        fileLabel?.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
        fileLabel?.textAlignment = NSTextAlignment.Center
        fileLabel?.layer.cornerRadius = 5.0
        fileLabel?.clipsToBounds = true
        fileLabel?.numberOfLines = 0
        fileLabel?.font = kFout
        fileLabel?.alpha = 0.25
        fileLabel?.textColor = UIColor.whiteColor()
        bgButton?.addSubview(fileLabel!)
    }
    
    func showTextFile(text:String, showTime:NSTimeInterval, distanceBtm:CGFloat) {
        self.bgButton?.hidden = false
        
        UIApplication.sharedApplication().keyWindow?.addSubview(bgButton!)

        fileLabel?.center = CGPointMake((bgButton?.center.x)!, distanceBtm)
        let textSize:CGSize = outFileSize(text, font: kFout, width: maxWidth)
        fileLabel?.bounds = CGRectMake(0, 0, textSize.width+10, textSize.height+10)
        fileLabel?.text = text
        UIView.animateWithDuration(0.25) { () -> Void in
            self.fileLabel?.alpha = 1.0;
        }
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.fileLabel?.alpha = 1.0;
            }) { (bool) -> Void in
                NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: Selector("hideTextLabel"), object: self)
                self.performSelector(Selector("hideTextLabel"), withObject: self, afterDelay: showTime)
        }
    }
    
    func hideTextLabel() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.fileLabel?.alpha = 0.25
            }) { (bool) -> Void in
            self.bgButton?.hidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
