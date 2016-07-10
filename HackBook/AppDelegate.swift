//
//  AppDelegate.swift
//  HackBook
//
//  Created by Antonio Benavente del Moral on 3/7/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
         //MARK: - Creando el modelo
        //  1.- Cargamos los datos y despues creamos la libreria porque así mantenemos independiente el modelo (libreria) del 
        // origen de los datos. Si tuvieramos los datos en una base de datos tan sólo habría que cambiar el origen de datos
        var datos:JSONArray = sourceJson()
        
        let libreryBook:Library = Library(ArrayBook: datos)
        
        //MARK: - Controllers
            
                  
        // Cargando el controlador
            
        // Creamos el controlador Bookview
            
        let vc = BookViewController(model:libreryBook.bookAtIndex(1, tag: "git"))
            
        // Creamos el controlador de Library
            
        let libvc = LibraryTableViewController(model: libreryBook)
            
        libvc.delegate = vc
            
        // Lo metemos en un navigation
            
        let unav = UINavigationController(rootViewController: vc)
        let navLib = UINavigationController(rootViewController: libvc)
            
        let splitVc = UISplitViewController()
        splitVc.viewControllers = [navLib, unav]
            
        window?.rootViewController = splitVc
            
        window?.makeKeyAndVisible()
        
    
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
