//
//  BookTableViewCell.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 5/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    
    @IBAction func viewPdf(sender: AnyObject) {
        print("HOLAxxx")
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
       
   
    
}
