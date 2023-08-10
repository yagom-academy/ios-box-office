//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import UIKit

@available(iOS 14.0, *)
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let boxOfficeViewController = BoxOfficeViewController()
        let navigationViewController = UINavigationController(rootViewController: boxOfficeViewController)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

