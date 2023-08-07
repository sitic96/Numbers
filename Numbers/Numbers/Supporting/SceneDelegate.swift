//
//  SceneDelegate.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootVC = storyboard.instantiateViewController(identifier: "GameViewController") as? GameViewController else {
            return
        }
        rootVC.engine = Engine.shared
        rootVC.engineIterator = EngineIterator(engine: Engine.shared)
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
}

