//
//  Book.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation

class Book{
    
    let title:String
    let coverUrl:NSURL
    let pdfUrl:NSURL
    
    // Tanto en tag como en author nos podemos planetar usar opcionales en el sentido que un libro puede venir etiquitada o 
    // ser anomimo. En este caso nos planteamos dos equitas por defecto untag para los tar y anomimous para los libros.
    // Esta solución nos proporciona las ventaje de que cuando agamos el controlador las sección seran roturlada directamente
    // como untag en el caso de los tar y Anonimous en el caso de los libros.
    
    let tag = [String]()
    
    // Para la variable de author nos hemos decantado por un array de Book en lugar de por un simple array porque en el futuro
    // si quieramos ampliar la clase podríamos querer contar con mas información del autor y solo tendríamos que ampliar la
    // estructura.
    // En cuanto  a la estructura vs clase podríamos haber usado cualquiera de las dos y con la dimensión de estu
    
    let authorsBook = [Book]()
    
    
}
