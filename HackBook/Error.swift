//
//  Error.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation



enum BookError:ErrorType{
    
    case wrongURLFormatForJSONResource
    case resourcePointedByURLNotReachable
    case JSONParsingError
    case wrongJSONFormat
    case nilJSONObject
    case FileError
    case WrongUrl
    case WrongConexion
}