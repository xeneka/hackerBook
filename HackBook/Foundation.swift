//
//  Foundation.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 8/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation

extension NSBundle{
    
    func URLforResourceName(name: String?) -> NSURL? {
        
        let components = name?.componentsSeparatedByString(".")
        let fileTitle = components?.first
        let fileExtension = components?.last
        
        return URLForResource(fileTitle, withExtension: fileExtension)
        
        
    }
    
}