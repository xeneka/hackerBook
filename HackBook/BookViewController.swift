//
//  BookViewController.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 5/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var cover: UIImageView!
    
    @IBOutlet weak var authors: UILabel!
    
    @IBOutlet weak var tags: UILabel!
    
    @IBAction func viewPdf(sender: AnyObject) {
        
        let vc = PdfViewController(model: model!)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: -  modelo
    
    var model:Book?
    
    init(model:Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    func syncModelWithView(){
        
        
        tags.text = model?.tags.joinWithSeparator("-")
        
        for auth in (model?.authorsBook)!{
            authors.text?.appendContentsOf(auth.name)
        }
        
        //let data:NSData = NSData(contentsOfURL: NSURL(string: (model?.coverUrl.absoluteString)!)!)!
        cover.image = (UIImage(data: NSData(contentsOfURL: (model?.coverUrl)!)!))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // Para que VC se ajuste al espacio que deja el navigation
        edgesForExtendedLayout = .None
        title = model?.title
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(bookDidchange), name: BookDidChangeNotification, object: nil)
        
        
        syncModelWithView()
        
    }
    
    func bookDidchange(notificacion: NSNotification){
        self.model = notificacion.userInfo![BookKey] as! Book
        
        syncModelWithView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BookViewController:LibreryTableViewControllerDelegate{
    
    func LibreryTableViewController(vc: LibraryTableViewController, book: Book) {
        model = book
        syncModelWithView()
    }
    
}
