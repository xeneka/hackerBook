//
//  JSONDecoding.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation


//MARK : - Aliases
typealias JSONObject        =   AnyObject
typealias JSONDictionary    =   [String : JSONObject]
typealias JSONArray         =   [JSONDictionary]


func getJSONFromUrl(urlToRequest: String) throws -> JSONArray{
    
    // Declaro la URL del recurso
    
    guard let urlFile = NSURL(string: urlToRequest) else {
        throw BookError.WrongUrl
    }
    
    
    // Cargo el contenido del fichero
    
    guard let data = NSData(contentsOfURL: urlFile) else{
        throw BookError.WrongConexion
    }
    
    
    guard  let maybeArray = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? JSONArray else{
        
        throw BookError.wrongJSONFormat
    }
    
    
    
    return maybeArray!
}


func arrayAuthor(authors:[String])->[Author]{
    
    var authorsBook = [Author]()
    
    for auth:String in authors{
        
        let myAuthors:Author = Author(name: auth)
        
        authorsBook.append(myAuthors)
    }
    
    return authorsBook
    
}





func decode(book json:JSONDictionary) throws -> Book{
    
    guard let urlString = json["pdf_url"] as? String,
        urlPdf = NSURL(string: urlString) else{
            throw BookError.wrongURLFormatForJSONResource
    }
    
    guard let urlStringImage = json["image_url"] as? String,
        urlImage = NSURL(string: urlStringImage) else{
            throw BookError.wrongURLFormatForJSONResource
    }
    
    guard let title = json["title"] as? String else{
            throw BookError.wrongURLFormatForJSONResource
    }
    
    guard let tags = json["tags"] as? String else{
        throw BookError.wrongURLFormatForJSONResource
    }
    
    
    guard let authors = json["authors"] as? String else{
        throw BookError.wrongURLFormatForJSONResource
    }
    
    
    
    let newBook:Book = Book(titleBook: title, coverUrl: urlImage, pdfUrl: urlPdf, bookTags: tags.componentsSeparatedByString(","), authorsBook: arrayAuthor(authors.componentsSeparatedByString(",")))
    
   
    
    return newBook
    
    
    
    
}

