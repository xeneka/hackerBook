//
//  JSONDecoding.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import UIKit


//MARK : - Aliases
typealias JSONObject        =   AnyObject
typealias JSONDictionary    =   [String : JSONObject]
typealias JSONArray         =   [JSONDictionary]

let keyFavorite = "keyFavorite"


func getJSONFromUrl(urlToRequest: String) throws -> JSONArray{
    
    // Declaro la URL del recurso
    
    guard let urlFile = NSURL(string: urlToRequest) else {
        throw BookError.WrongUrl
    }
    
    
    // Cargo el contenido del fichero
    
    guard let data = NSData(contentsOfURL: urlFile) else{
        throw BookError.WrongConexion
    }
    
    if saveJSONFromUrlRequest(data) {
        print("Escribio el ficheros")
    }else{
        print("No escribio el fichero")
    }
    

    
    let dataArray:JSONArray
    
    do{
        
        dataArray = try JSONfromNSData(data)
        
        // OJO Esto pasarlo a GCD
        saveAllObjfromJSON(dataArray)
        // FIND
        
        return dataArray
    }catch  {
        throw BookError.WrongFile
    }
    
    
    
    
    
}


func JSONfromNSData(data:NSData) throws -> JSONArray {
    
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


func saveJSONFromUrlRequest(data:NSData) -> Bool{
    
    
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let writePath = NSURL(fileURLWithPath: "file://"+path[0]).URLByAppendingPathComponent("hackbookurl")
    
    
    
    return data.writeToURL(writePath, atomically: true)
    
    
}

func saveObjectJson(url:NSURL){
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    
    
    let writePath = NSURL(fileURLWithPath: "file://"+path[0]).URLByAppendingPathComponent(url.lastPathComponent!)
    
    // Poner cental dispatch para ejecutarla
    
    
    if let data:NSData = NSData(contentsOfURL: url){
        data.writeToURL(writePath, atomically: true)
    }
    
    
    
    
    
}



func getJSONFromLocalDisk()throws -> JSONArray {
    
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let writePath = NSURL(fileURLWithPath: "file://"+path[0]).URLByAppendingPathComponent("hackbookurl")
    //guard let data:NSData = NSData(contentsOfFile: path[0]) else{
    guard let data:NSData = NSData(contentsOfURL: writePath) else{
        
        throw BookError.WrongFile
    }
    
    let dataArray:JSONArray
    
    do{
    
        dataArray = try JSONfromNSData(data)
            return dataArray
        }catch  {
            throw BookError.WrongFile
        }
    
   
    
}



func sourceJson() ->JSONArray{
    let userDefaultProperties = NSUserDefaults.standardUserDefaults()
    
    var datos:JSONArray = JSONArray()
    
    if let name = userDefaultProperties.stringForKey("hackbook"){
        // recupero el fichero de sandbox
        print("Leyendo de Disco");
        datos = try! getJSONFromLocalDisk()
    }else{
        // LEo el fichero de la url
        print("Leyendo de Internet")
        datos = try! getJSONFromUrl("https://t.co/K9ziV0z3SJ")
        userDefaultProperties.setBool(true, forKey: "hackbook")
    }
    
    return datos
    
}






// Recorre el diccionario y guarda en local las url de los pdf y de las imagenes
func saveAllObjfromJSON(data:JSONArray){
    
    for bks in data{
        
     
       
        if let urlImg = NSURL(string: bks["image_url"] as! String) , let urlPdf = NSURL(string: bks["pdf_url"] as! String) {
           
            saveObjectJson(urlImg)
            saveObjectJson(urlPdf)
            
        }
      
    }
    
}



// Devuelve el recurso almacenado en disco

func objFromDisk(data:String) throws -> NSData{
    
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    
    
    if let urlD = NSURL(string: data)?.lastPathComponent{
    
        let readPath = NSURL(fileURLWithPath: "file://"+path[0]).URLByAppendingPathComponent(urlD)
       
        if let contenido = NSData(contentsOfURL: readPath){
            return contenido
        }
    }
 
    throw BookError.WrongFile
}


func favoriteSave(favorites:[Book]){
    
    var array = [String]()
    
    for b in favorites{
        array.append(b.title)
    }
    
    var defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(array, forKey: keyFavorite)
    
    
}

func favoriteRestore()->[String]{
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var array = [String]()
    
    if let arrayFavorite:AnyObject? = defaults.objectForKey(keyFavorite){
            array = arrayFavorite as! [String]
    }
    
    
    return array
}




