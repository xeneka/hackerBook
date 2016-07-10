//
//  LibraryTableViewController.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 5/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

let BookDidChangeNotification = "BookChange"
let BookKey = "Key"


class LibraryTableViewController: UITableViewController {
        
    //MARK: - Properties
    
    let model:Library?
    var delegate:LibreryTableViewControllerDelegate?
    
    init(model:Library){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    let nc = NSNotificationCenter.defaultCenter()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        title = "Library"
        
        nc.addObserver(self, selector: #selector(changeFavorite), name: FavoriteDidChangeNotification, object: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "BookTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "bookCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (model?.numberOfTag())!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (model?.countBookForTag(getKeyforSection(section)))!
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return getKeyforSection(section)
        
        
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Tipo de celda
        
        let cellId = "bookCell"
        
        
        // Averiguar el libro
        
       // let character = model.character(atIndex: indexPath.row, forAffiliation: getAffiliation(forSection: indexPath.section))
        
        // crear celda
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! BookTableViewCell
        
        
        
//        if cell == nil {
//            // el optionalesta vacila
//            
//            //let celda:UINib = UINib(nibName: "BookTableViewCell", bundle: nil)
//            //tableView.registerNib(celda, forCellReuseIdentifier: cellId)
//            cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! BookTableViewCell
//        
//            //cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
//            
//        }
        
        let book = model?.bookAtIndex(indexPath.row, tag: getKeyforSection(indexPath.section))
        
        
        cell.bookTitle.text = book?.title
        cell.favorite.hidden = !(book?.favorite)!
      
        
//        cell.index = indexPath.row
//        cell.seccion = getKeyforSection(indexPath.section)
        
        
        
        
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let book = model?.bookAtIndex(indexPath.row, tag: getKeyforSection(indexPath.section))
        
        
        
        let vc = LibraryTableViewController(model: self.model!)
        
        delegate?.LibreryTableViewController(vc, book: book!)
        
        //Enviamos notifiacion
        
        
        
        let notif = NSNotification(name: BookDidChangeNotification, object: self, userInfo: [BookKey:book!])
        
        nc.postNotification(notif)
        
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - utilities
    
    func getKeyforSection(index:Int) -> String{
        
        var sectionString = model?.tagDict.keys.sort()
        
        if let order = sectionString?.indexOf("❤ favoritos"){
            sectionString?.removeAtIndex(order);
            sectionString?.insert("❤ favoritos", atIndex:0)
            
        }
        
        
        return sectionString![index]
    }
    
    func changeFavorite(notificacion:NSNotification){
        
        let info = notificacion.userInfo!
        let book = info[bookKey] as! Book
        model?.marcaDesmarcaFavorie(book)
        //model?.addFavorite(book)
        tableView.reloadData()
    }
    
    
}


//MARK: - protocol

protocol LibreryTableViewControllerDelegate{
    func LibreryTableViewController(vc:LibraryTableViewController, book:Book)
}

////MARK: -  Protocolo

extension LibraryTableViewController:LibreryTableViewControllerDelegate{
    
    func LibreryTableViewController(vc: LibraryTableViewController, book: Book) {
       
        
        let vc = BookViewController(model: book)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}




