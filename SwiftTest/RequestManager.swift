//
//  ReqiestManager.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/28.
//  Copyright © 2016年 qz. All rights reserved.


//

import Alamofire
import UIKit

let WebServiceNameSpace:String = "http://tempuri.org/"

class RequestManager: NSObject {
    //MARK:  =====HPH 后台=====
    ///post请求
    class func postWithURLString(urlString:String, params:NSDictionary, success:((AnyObject) -> Void), failure:((NSError) -> Void) ) {
        let request = Alamofire.request(.POST, urlString, parameters: params as? [String : AnyObject], encoding: .URL, headers: nil)
        request.responseJSON { response -> Void in
            if let error = response.result.error {
                failure(error)
            } else if let json = response.result.value {
                success(json)
            }
        }
    }
    ///GET请求
    class func getWithURLString(urlString:String, params:NSDictionary, success:((AnyObject) -> Void), failure:((NSError) -> Void) ) {
        let request = Alamofire.request(.GET, urlString, parameters: params as? [String : AnyObject], encoding: .URL, headers: nil)
        request.responseJSON { response -> Void in
            if let error = response.result.error {
                failure(error)
            } else if let json = response.result.value {
                success(json)
            }
        }
    }
    //表单上传image
    class func uploadFileWithImage(image:UIImage, urlString:String, params:NSDictionary, success:((AnyObject) -> Void), failure:((NSError) ->Void) ) {
        
    }
    
    //MARK:  =====.NET 后台=====
    class func asyncWithURLString(urlString:String, methodName:String, params:NSDictionary, success:((AnyObject) -> Void), failure:((NSError) -> Void) ) {
        
        let url:NSURL = NSURL(string: urlString)!
        
        let soapMessage:String = SoapHelper.dictToDefaultSoapMessage(params, methodName: methodName)
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        urlRequest.addValue(url.host!, forHTTPHeaderField: "Host")
        urlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("\(WebServiceNameSpace)\(methodName)", forHTTPHeaderField: "SOAPAction")
        urlRequest.addValue("\(soapMessage.characters.count)", forHTTPHeaderField: "Content-Length")
        urlRequest.HTTPMethod = "POST"
        urlRequest.timeoutInterval = 20.0
        urlRequest.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let request = Alamofire.request(urlRequest)
        request.responseData { response -> Void in
            if let error = response.result.error {
                failure(error)
            } else if let json = response.result.value {
                let valueData:NSData = json as NSData
                let resultString : String = NSString(data: valueData, encoding: NSUTF8StringEncoding)! as String
                var tempString = resultString.componentsSeparatedByString("<\(methodName)Result>")[1]
                tempString = tempString.componentsSeparatedByString("</\(methodName)Result>")[0]
                
                let dataStr = tempString.dataUsingEncoding(NSUTF8StringEncoding)
                let jsonData = try? NSJSONSerialization.JSONObjectWithData(dataStr!, options: NSJSONReadingOptions.AllowFragments)
                success(jsonData!)
            }
        }
    }
}
