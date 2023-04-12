//
//  AppDelegate.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BoxOfficeCoreData")
        let fileManager = FileManager.default
        let cacheDirectoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = cacheDirectoryURL.appendingPathComponent("BoxOfficeCoreData.sqlite")
        let description = container.persistentStoreDescriptions.first
        
        description?.url = persistentStoreURL
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        })

        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MovieAttributeTransformer.register()
        DetailsAttributeTransformer.register()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

