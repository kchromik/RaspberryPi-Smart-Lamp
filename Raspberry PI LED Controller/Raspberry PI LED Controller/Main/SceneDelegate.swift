//
//  SceneDelegate.swift
//  Raspberry PI LED Controller
//
//  Created by Kevin Chromik on 08.10.19.
//  Copyright © 2019 Kevin Chromik. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = LampViewController()
            self.window = window
            window.makeKeyAndVisible()
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

