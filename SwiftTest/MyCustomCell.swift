//
//  MyCustomCell.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/15.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    var label = UILabel()
    var button = UIButton()
    
    // 闭包 类似oc中的block
    var cellButtonBlock:((button:UIButton) -> Void )?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
        
    }
    func initView () {
        label = UILabel(frame: CGRectZero)
        label.numberOfLines = 0
        label.textColor = UIColor.clearColor()
        label.font = UIFont.systemFontOfSize(17)
        label.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(label)
        
        button = UIButton(type: UIButtonType.Custom)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.titleLabel?.font = UIFont.systemFontOfSize(16)
        button.setTitleColor(SET_RGB_COLOR(100, g: 100, b: 100), forState: UIControlState.Normal)
        //绑定方法(2)
        button.addTarget(self, action: Selector("didButtonClick:"), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(button)
    }
    
    override func layoutSubviews() {
        label.frame = CGRectMake(10, 0, self.frame.size.width/2-10, self.frame.size.height)
        button.frame = CGRectMake(self.frame.width/2, 0, self.frame.size.width/2-10, self.frame.size.height)
    }
    
    func didButtonClick(button:UIButton) {
        if cellButtonBlock != nil {
            self.cellButtonBlock!(button :button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
