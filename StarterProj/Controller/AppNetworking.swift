//
//  AppNetworking.swift
//  StarterProj
//
//  Created by Gurdeep on 16/12/16.
//  Copyright © 2016 Gurdeep. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]


extension Notification.Name {

    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum AppNetworking {

    static func POST(endPoint : WebServices.EndPoint,
                     parameters : JSONDictionary = [:],
                     headers : JSONDictionary = [:],
                     loader : Bool = true,
                     success : @escaping (JSON) -> Void,
                     failure : @escaping (Error) -> Void) {
        
        
        request(URLString: endPoint.rawValue, httpMethod: .post, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func GET(endPoint : WebServices.EndPoint,
                    parameters : JSONDictionary = [:],
                    headers : JSONDictionary = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        request(URLString: endPoint.rawValue, httpMethod: .get, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    
    static func PUT(endPoint : WebServices.EndPoint,
                    parameters : JSONDictionary = [:],
                    headers : JSONDictionary = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        request(URLString: endPoint.rawValue, httpMethod: .put, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }

    static func DELETE(endPoint : WebServices.EndPoint,
                    parameters : JSONDictionary = [:],
                    headers : JSONDictionary = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        request(URLString: endPoint.rawValue, httpMethod: .delete, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    private static func request(URLString : String,
                         httpMethod : HTTPMethod,
                         parameters : JSONDictionary = [:],
                         headers : JSONDictionary = [:],
                         loader : Bool = true,
                         success : @escaping (JSON) -> Void,
                         failure : @escaping (Error) -> Void) {
    
        
        if loader { showLoader() }
        
        Alamofire.request(URLString, method: httpMethod,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            if loader { hideLoader() }

            switch(response.result) {
                
            case .success(let value):
                
                print(value)
                
                success(JSON(value))
                
            case .failure(let e):
                
                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                    
                    // Handle Internet Not available UI
                    
                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                }

                failure(e)
            }
        }
    }

}
