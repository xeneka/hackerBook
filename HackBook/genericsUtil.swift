//
//  genericsUtil.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 5/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import UIKit

func verifyUrlResponse (url: NSURL) -> Bool {
    
    var config : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    var session : NSURLSession = NSURLSession(configuration: config)
    let request:NSURLRequest = NSURLRequest(URL: url)
    var conexion:Bool = false
    
    
    let dataTask = session.dataTaskWithRequest(request){
        (let data, let response, let error) in
        
        if let httpResponse = response as? NSHTTPURLResponse{
            
            if (httpResponse.statusCode == 200){
                conexion = true
            }
            
        }
    }
    return conexion
    
}

