//
//  ViewController.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/15.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.title = "登陆"
        
        initView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    //初始化subView
    func initView () {
        
        //输入框
        var textArray = ["账号", "密码"]
        let placArray = ["请输入您的账号", "请输入账号密码"]
        let starX: CGFloat = 25.0
        let height: CGFloat = 90.0
        //for in 循环(1)
        for i in 0..<textArray.count {
            let textLabel = UILabel(frame: CGRectMake(starX, 89 + (height * CGFloat(i)), KScreenWidth - starX * 2, 30))
            textLabel.text = textArray[i]
            textLabel.textColor = .whiteColor();
            self.view.addSubview(textLabel)
            
            let TF = UITextField(frame: CGRectMake(starX, CGRectGetMaxY(textLabel.frame), CGRectGetWidth(textLabel.frame), 40))
            TF.borderStyle = .RoundedRect
            TF.textColor = .blackColor()
            TF.placeholder = placArray[i]
            self.view.addSubview(TF)
            if i==1 {
                TF.secureTextEntry = true
            } else {
                TF.keyboardType = .NumberPad
            }
        }
        //按钮
        let button = UIButton(frame: CGRectMake(0, 0, KScreenWidth-(starX * 2), 44))
        button.center = CGPointMake(self.view.center.x, self.view.center.y+50)
        button.backgroundColor = .redColor()
        button.setTitle("登陆", forState: .Normal)
        button.addTarget(self, action: "didSelectButtonClick:", forControlEvents: .TouchUpInside)
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        button.setBackgroundImage(alongPointWithImageName(CGPointMake(50,22), image:UIImage(named: "button_bg001")!), forState: .Normal)
        self.view.addSubview(button)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    
    ///  >>>按钮点击事件<<<
    func didSelectButtonClick (button: UIButton) {
//        print("输出字符串+对象:\(button)")
        let dict = ["app":"Bts",
                    "class":"SelectItem",
                    "sign":"02abe7657f66f7816790b7bb0b2f3389",
                    "businessscope_id":"1"]
        RequestManager.postWithURLString("http://www.sinmu.net/api", params:dict, success: { (object) -> Void in
            let value = object["status"]
            if value as! NSObject == 1 {
                MyPrompt.sharedInstance.showTextFile(object["msg"] as! String, showTime: 1.0, distanceBtm: KScreenHeight-200)
            } else {
//                print(object)

                let homeVC = HomeViewController()
                
                let leftVC = LeftViewController()
                let rightVC = RightViewController()
                let drawerController = DrawerController(centerViewController: homeVC, leftDrawerViewController: leftVC, rightDrawerViewController: rightVC)
                drawerController.maximumLeftDrawerWidth=130
                drawerController.maximumRightDrawerWidth=110
                drawerController.openDrawerGestureModeMask = OpenDrawerGestureMode.PanningCenterView
                drawerController.closeDrawerGestureModeMask = CloseDrawerGestureMode.All
                drawerController.view.backgroundColor = UIColor.whiteColor()
                drawerController.title = "首页"
                self.navigationController?.pushViewController(drawerController, animated: true)
                
                MyPrompt.sharedInstance.showTextFile("获取数据成功 进入首页", showTime: 1.5, distanceBtm: KScreenHeight-200)

            }
            }) { (error) -> Void in
                print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// 缩放image
    func alongPointWithImageName(point:CGPoint, image:UIImage) ->UIImage {
        let newImage = image.stretchableImageWithLeftCapWidth(NSInteger(point.x), topCapHeight: NSInteger(point.y))
        return newImage
    }

}

