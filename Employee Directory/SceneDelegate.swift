//
//  SceneDelegate.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Add a UINavigationController and have the employees list be the root
        let viewController = EmployeesListViewController()
        let navViewController = UINavigationController(rootViewController: viewController)
        
        // We do this instead of a storyboard
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navViewController
        window?.makeKeyAndVisible()
    }
}
