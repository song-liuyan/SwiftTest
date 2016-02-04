//
//  SoapHelper.swift
//  SwiftTest
//
//  Created by 清正 on 16/2/3.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit


class SoapHelper: NSObject {
    
    class func dictToDefaultSoapMessage(dictionary:NSDictionary, methodName:String) -> String {
        let dict:NSDictionary? = dictionary
        
        let tempSoap = SoapHelper.methodSoapMessage(methodName)

        if (dict == nil || dict!.count == 0) {
            return tempSoap.stringByReplacingOccurrencesOfString("%@", withString: "")
        } else {
            let temp:NSMutableString = NSMutableString(string: "")
            for (key, value) in dictionary {
                temp.appendString("<\(key)>")
                temp.appendString("\(value)")
                temp.appendString("</\(key)>")
            }
            return tempSoap.stringByReplacingOccurrencesOfString("%@", withString: temp as String)
        }
    }
    
    class func defaultSoapMesage() ->String {
        let soapBody1:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        let soapBody2:String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        let soapBody3:String = "<soap:Body>%@</soap:Body></soap:Envelope>";
        return "\(soapBody1)\n\(soapBody2)\n\(soapBody3)";
    }
    
    private class func methodSoapMessage(methodName:String) ->String {
        let mutableSoap:NSMutableString = NSMutableString(string: "<\(methodName) xmlns=\"\(WebServiceNameSpace)\">")
        mutableSoap.appendString("%@")
        mutableSoap.appendFormat("</\(methodName)>");
        
        let defaultSoap:String = defaultSoapMesage()
        
        return defaultSoap.stringByReplacingOccurrencesOfString("%@", withString: mutableSoap as String)
    }
}
