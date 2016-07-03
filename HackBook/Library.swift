//
//  Library.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation

class Library{
    
    var Books = [Book]()
    var Tags: NSMutableArray
    
    
    init(Library Books:[Book], Tags:NSMutableArray){
        self.Books = Books
        self.Tags = Tags
        
        
    }
    
    
    
    
}
