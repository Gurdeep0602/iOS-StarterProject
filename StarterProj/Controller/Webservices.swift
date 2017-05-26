//
//  Webservices.swift
//  StarterProj
//
//  Created by Gurdeep on 16/12/16.
//  Copyright © 2016 Gurdeep. All rights reserved.
//

import Foundation
import SwiftyJSON

enum WebServices {

}

extension NSError {

    convenience init(localizedDescription : String) {
        
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}

extension WebServices {

    static func login(parameters : JSONDictionary, success : @escaping (UserModel) -> Void, failure : @escaping (Error) -> Void) {
    
        var p = parameters
        
        p["access-token"] = "DummyValue"
        
        // Configure Parameters and Headers
        
        AppNetworking.POST(endPoint: .Login, parameters: p, loader : true,
                           success: { (json : JSON) -> Void in
                
                guard let userData = json["json"].dictionary else {
                    
                    let e = NSError(localizedDescription: "")
                    
                    // check error code and present respective error message from here only
                    
                    failure(e)
                    
                    return
                }
                            
                let username = userData["username"]!.stringValue
                let user = UserModel(username: username)
                success(user)
                
        }, failure: {(e : Error) -> Void in
        
            // Handle respective error for login
            failure(e)
        })
        
    }
}
