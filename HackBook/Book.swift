//
//  Book.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import UIKit

class Book{
    
    let title:String
    let coverUrl:NSURL
    let pdfUrl:NSURL
    var favorite:Bool
    
    // Tanto en tag como en author nos podemos planetar usar opcionales en el sentido que un libro puede venir etiquitada o 
    // ser anomimo. En este caso nos planteamos dos valores por defecto untag para los tar y anomimous para los libros.
    // Esta solución nos proporciona las ventaja de que cuando hagamos el controlador las sección serán rotuladas directamente
    // como untag en el caso de los tar y Anonimous en el caso de los libros.
    
    
    // No nos plantemos el hacer tag como una enum debido al gran número de opciones que hay para libros
    
    var tags = [String]()
    
//     Para la variable de author nos hemos decantado por un array de Book en lugar de por un array se String porque en el futuro si quieramos ampliar la clase podríamos querer contar con mas información del autor y solo tendríamos que ampliar la
//     estructura.
//     En cuanto  a la estructura vs clase podríamos haber usado cualquiera de las dos y con la dimensión de estructura 
//     no afectara al rendimiento pero creo que segun la WWDC para el tema de las variables asignación etc es mejor las struct
//     Info https://developer.apple.com/videos/play/wwdc2015/408/
    
    var authorsBook = [Author]()
    
    
    //Mark; Proxies
    
    // Para compara libros solo utilizo el titulo ya que el resto de parametros pueden ser diferenctes para el mismo libro
    // puedo tener el mismo libro en dos sitios de internet con diferente url pero igual contenido.
    
    var proxyForComparison:String{
        get{
            return "\(title)";
        }
    }
    
    
    
    
    init(titleBook title:String, coverUrl cover:NSURL, pdfUrl pdf:NSURL, bookTags tags:[String], authorsBook authors:[Author], favorite:Bool){
        
        self.title = title
        coverUrl = cover
        pdfUrl = pdf
        self.tags = tags
        authorsBook = authors
        self.favorite = favorite
        
        
    }
    
   convenience init(titleBook title:String, coverUrl cover:NSURL, pdfUrl pdf:NSURL, bookTags tags:[String], authorsBook authors:[Author]){
    
    
        self.init(titleBook: title, coverUrl: cover, pdfUrl: pdf, bookTags: tags, authorsBook: authors,favorite: false)
        
    }
    
    
    // En esta función llamamos al funcion que gestiono la carga de datos para que nos devuelva la imagen
    // En caso de cambiar el origne de datos por ejemplo una base de datos o no guardar los datos en el dispositivo
    // el origen actura en consecuencia independizandolo del modelo.
    // Como mejora en la sieguiente versión podemos usar un protocolo que daba implementar el origen de datos
    
    func showImage() -> UIImage{
        var image:UIImage = UIImage(named: "noexist.jpg")!
        do{
            image = (UIImage(data: try objFromDisk((coverUrl.absoluteString))))!
            
        }catch{
            
        }
        
      return image
    }
    
    func showPdf() -> NSData{
        
        let bundle:NSBundle = NSBundle.mainBundle()
        let url = bundle.URLForResource("noexist", withExtension: "pdf")
        
        var pdf:NSData = NSData(contentsOfURL: url!)!
        do{
            pdf = try objFromDisk(pdfUrl.absoluteString)
        }catch{
            
        }
     
        return pdf
    }
    
    
}


//: Mark Equatable

func == (lhs: Book, rhs:Book) -> Bool{
    
    // Comparo posiciones de memoria con el triple ===
    guard (lhs !== rhs) else{
        return true
    }
    
    return lhs.proxyForComparison == rhs.proxyForComparison
    
}
