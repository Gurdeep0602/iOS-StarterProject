//
//  Globals.swift
//  StarterProj
//
//  Created by Gurdeep on 09/03/17.
//  Copyright © 2017 Gurdeep. All rights reserved.
//

import Foundation


func printDebug<T>( obj : T) {
    print(obj)
}

func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}
