//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

@available(iOS 14.0, *)
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

