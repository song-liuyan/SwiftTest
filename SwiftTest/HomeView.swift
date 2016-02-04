//
//  HomeView.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/15.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit

//swift 枚举
public enum MyButtonType : Int {
    case LeftToRight = 0
    case RightToLeft
    case UpToDown
    case DownToUp
}
//代理协议
@objc protocol MyButtonDelegate : NSObjectProtocol {
    optional func didButtonClick(view: HomeView)
}

//swift 自定义类
class HomeView: UIControl {

    //声明全局属性
    var button:UIButton!
    var label :UILabel!
    //声明枚举
    var type :MyButtonType!
    //代理声明
    weak var delegate :MyButtonDelegate!
    //重写初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //由于继承UIControl 所以可绑定方法(1)
        self.addTarget(self.superview, action: "didButtonClick:", forControlEvents: .TouchUpInside)
        
        button = UIButton(type: .Custom)
        button.titleLabel!.font = UIFont.systemFontOfSize(16)
        button.titleLabel!.numberOfLines = 0;
        button.userInteractionEnabled = false
        button.backgroundColor = UIColor.clearColor()
        self.addSubview(button)
        
        label = UILabel(frame: CGRectZero)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(16)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0;
        label.backgroundColor = UIColor.clearColor()
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        let textH:CGFloat = outFileSize((label.text)!, font:UIFont.systemFontOfSize(16), width: self.frame.size.width).height
        
        let selfWidth = self.frame.width
        let selfHeight = self.frame.height
        
        if type == MyButtonType.UpToDown {
            label.frame = CGRectMake(0, selfHeight-textH-5, selfWidth, textH+5)
            button.frame = CGRectMake(0, 0, selfWidth, selfHeight-CGRectGetHeight(label.frame))
        } else if type == MyButtonType.DownToUp {
            label.frame = CGRectMake(0, 0, selfWidth, textH+5)
            button.frame = CGRectMake(0, CGRectGetHeight(label.frame), selfWidth, selfHeight-CGRectGetHeight(label.frame))
        } else if type == MyButtonType.LeftToRight {
            label.frame = CGRectMake(selfWidth/2, 0, selfWidth/2, selfHeight)
            label.textAlignment = .Left
            button.frame = CGRectMake(0, 0, selfWidth/2, selfHeight)
        } else if type == MyButtonType.RightToLeft {
            label.frame = CGRectMake(0, 0, selfWidth/2, selfHeight)
            label.textAlignment = .Right
            button.frame = CGRectMake(selfWidth/2, 0, selfWidth/2, selfHeight)
        }
    }
    
    func didButtonClick(control:HomeView) {
        //可选方法实现
        if self.delegate != nil && self.delegate.respondsToSelector("didButtonClick:") {
            self.delegate?.didButtonClick!(control)
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
