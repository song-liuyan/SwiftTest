//
//  HomeViewController.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/15.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MyButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页";
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = true;
        
        initView()
    }
    
    func initView () {
        let btnTexts = ["测试", "看书", "学习", "写代码"]
        let btnWidth:CGFloat = KScreenWidth / CGFloat(btnTexts.count);
        var lastView:UIView!
        //for in 循环(2)
        for index in 0...btnTexts.count-1 {
            let myView = HomeView(frame: CGRectMake(CGFloat(index)*btnWidth, 64, btnWidth, 65));
            myView.backgroundColor = SET_RGB_COLOR(242, g: 242, b: 242)
            myView.label.text = btnTexts[index]
            myView.button .setImage(UIImage(named: "integral"), forState: UIControlState.Normal)
            myView.type = MyButtonType.DownToUp;
            myView.delegate = self;
            self.view.addSubview(myView);
            lastView = myView
        }
        
        let tableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(lastView.frame), KScreenWidth, KScreenHeight-CGRectGetMaxY(lastView.frame)), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        tableView.separatorColor = UIColor.redColor()
        tableView.separatorStyle = .None;
        self.view.addSubview(tableView)
    }
    //实现代理方法
    func didButtonClick(control:HomeView) {
        let string:String = "\(control.label.text ?? "空")"  //如果 ?? 前面对象为nil 则赋值后面的
        let firstVC = FirstViewController()
        firstVC.homeString = string
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:MyCustomCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? MyCustomCell
        if cell==nil {
            cell = MyCustomCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "cell") as MyCustomCell
            let lineView = UIView(frame: CGRectMake(0, 60-1, KScreenWidth, 1))
            lineView.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
            cell?.contentView .addSubview(lineView)
        }
        cell?.label.text = "清正"
        cell?.button.setTitle("按钮", forState: UIControlState.Normal)
        cell?.cellButtonBlock = { (button:UIButton) -> () in
            let btnTitle:String = button.titleForState(.Normal)!
            
            RequestManager.asyncWithURLString("http://103.21.118.204:8088/Interface/BannerServer.asmx", methodName: "GetBannerList", params: ["Top":"5"], success: { (object) -> Void in
                
                print("json=\(object)")
                
                }, failure: { (error) -> Void in
                    
                    print("error=\(error)")
            })
            MyPrompt.sharedInstance.showTextFile("cell闭包 被调 indexRow=\(indexPath.row) Title= \(btnTitle)", showTime: 2.0, distanceBtm: KScreenHeight-200)
        }
        cell?.label.textColor = UIColor.grayColor()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        [tableView .deselectRowAtIndexPath(indexPath, animated: true)]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
