//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/28.
//

import UIKit

@available(iOS 16.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let dailyBoxOfficeViewController = DailyBoxOfficeViewController()
        
        let navigationController = UINavigationController(rootViewController: dailyBoxOfficeViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

