//
//  FirstViewController.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/28.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var homeString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = homeString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func upload(url:String, fileDate:NSData, fileName:NSString, newImgSize:CGSize, completionHandler:(data:AnyObject)->Void) {
        print("update:\(url)")
        
        let Boundary:NSString = "*****"
        let StartBoundary = NSString(format:"--%@",Boundary)
        var EndBoundary = NSString(format:"%@--", StartBoundary)
        let body = NSMutableString()
        
        body.appendFormat("%@\r\n",StartBoundary)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
        body.appendString("Content-Type: image/jpeg\r\n\r\n")
        
        EndBoundary = NSString(format: "\r\n%@\r\n", EndBoundary)
        let requestData = NSMutableData()
        requestData.appendData(body.dataUsingEncoding(NSUTF8StringEncoding)!)
        requestData.appendData(fileDate)
        requestData.appendData(EndBoundary.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        let req = NSMutableURLRequest(URL:NSURL(string: url)!)
        req.HTTPMethod = "POST"
        req.setValue("multipart/form-data; boundary=\"*****\"; charset=\"UTF-8\"", forHTTPHeaderField: "Content-Type")
        req.setValue("\(requestData.length)", forHTTPHeaderField: "Content-Length")
        req.HTTPBody = requestData
        
        let queue = NSOperationQueue.mainQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue(), {
                    print(error)
                    completionHandler(data:NSNull())
                })
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode != 200 { //正常返回走这边
                        print("sendAsynchronousRequest status code = \(statusCode); response = \(response)")
                    } else {
                        let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                        dispatch_async(dispatch_get_main_queue(), {
                            completionHandler(data:jsonData!)
                            
                        })
                    }
                }
            }
        });
        
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
