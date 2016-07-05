//
//  Library.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation

class Library{
    
    //Mark: Utility types
    
    typealias BooksArray = [Book]
    
    // La estructura tiene que responder a dos preguntas: Numero de Tag y Libros de un tag. De esta forma iremos añadiendo a cada tag los libros que vayamos cargando
    
    
    
    typealias TagDictionary = [String : BooksArray]
    
    
    //MARK: - Properties
    
    var Books = [Book]()
    
    var tagDict:TagDictionary = TagDictionary()
    
    //MARK: - Store properties
    
    var bookCount:Int{
        get{
            return Books.count
        }
    }
    
    
    
    //MARK: - function
    
    func countBookForTag(tag:String) -> Int{
    
        if let numberBookTag = tagDict[tag]{
           
            return numberBookTag.count
        }else{
            return 0
        }
        
    }
    
    
    func bookForTag(tag: String) ->BooksArray{

        // No pongo un if let o guard porque debe contener datos ya que los tag los facilito yo
        
        return tagDict[tag]!
        
    }
    
    func numberOfTag()->Int{
    
        
        return tagDict.count
    }
    
    func bookAtIndex(index: Int, tag:String) -> Book{
        
        let tagBook = tagDict[tag]
        
        return tagBook![index]
    }
    
    
    
    
    
    
    init(Library Books:[Book]){
        
        // Ordeno los libros que me han cargado. 
        
        self.Books = Books.sort({$0.title < $1.title})
        
        
        
        
        // Leo todos los libros de la libreria
        for book in Books{
            // Doy de alta todos los tag, los tags no se repiten porque los dos de alta como clave en el diccionario
            for tag in book.tags{
                
                if let tagD = tagDict[tag.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())]{
                    
                }else{
                    
                    tagDict[tag.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())] = BooksArray()
                }
                
                tagDict[tag.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())]?.append(book)
                
            }
            
        
        }
        
        
    
    }
    
    
    
    
}
