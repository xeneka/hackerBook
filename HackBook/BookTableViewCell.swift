//
//  BookTableViewCell.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 5/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit


class BookTableViewCell: UITableViewCell {

    //MARK: -  properties
    
    var index:Int?
    var seccion:String?
    
    //MARK: - xib
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBAction func viewPdf(sender: AnyObject) {
    
        
    }
   
    
    
    @IBOutlet weak var favorite: UIImageView!
   
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
    
   
    
}
