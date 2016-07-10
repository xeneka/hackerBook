//
//  PdfViewController.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 5/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController {

    
    //MARK: - Properties
    
    @IBOutlet weak var viewpdf: UIWebView!
    
    var model:Book?
    
    init(model:Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(bookDidchange), name: BookDidChangeNotification, object: nil)
        
        syncronizeModel()
    
    }
    
    
    func syncronizeModel(){
       
        
               viewpdf.loadData((model?.showPdf())!, MIMEType: "application/pdf", textEncodingName: "", baseURL: (model?.pdfUrl.URLByDeletingLastPathComponent)!)
        
        
    }
    
    
    
    //MARK: - util
    
    func bookDidchange(notificacion: NSNotification){
        self.model = notificacion.userInfo![BookKey] as! Book
        
        syncronizeModel()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
