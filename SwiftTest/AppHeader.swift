//
//  AppHeader.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/15.
//  Copyright © 2016年 qz. All rights reserved.
//

/*  //相当于OC中 .pch/header.h文件
*   由于Swift 无宏定义 所以常用的常量可以统一写在一个类
*/

import Alamofire
import Foundation
import UIKit


let screenBound:CGRect = UIScreen.mainScreen().bounds
//是否为iphone4
let IS_IPHONE_4:Bool = fabs(Double( CGRectGetHeight(screenBound)) - Double(480))   < DBL_EPSILON

//是否为iphone5
let IS_IPHONE_5:Bool = fabs(Double( CGRectGetHeight(screenBound)) - Double(568))   < DBL_EPSILON

//是否为iphone6
let IS_IPHONE_6:Bool = fabs(Double( CGRectGetHeight(screenBound)) - Double(667))   < DBL_EPSILON

//是否为iphone6Plus
let IS_IPHONE_6PLUS:Bool = fabs(Double( CGRectGetHeight(screenBound)) - Double(736))   < DBL_EPSILON

//获取屏幕宽度
let KScreenHeight:CGFloat = UIScreen.mainScreen().bounds.height

//获取屏幕高度
let KScreenWidth :CGFloat = UIScreen.mainScreen().bounds.width

//导航栏 + 状态栏高度
let KNavTopH:CGFloat =  64
//设置颜色
func SET_RGB_COLOR (r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
//计算文字长宽
func outFileSize (file:NSString, font:UIFont, width:CGFloat) -> CGSize {
    let rect:CGRect = file.boundingRectWithSize(CGSizeMake(width, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes:[NSFontAttributeName :font], context: nil)
    return rect.size
}


