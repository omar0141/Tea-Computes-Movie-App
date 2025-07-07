//
//  SceneDelegate.swift
//  movie-app
//
//  Created by Omar on 06/07/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "MainViewController", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        // Set up the router with storyboard
        AppRouter.shared.setNavigationController(navigationController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
