//
//  SceneDelegate.swift
//  SwifterDemoiOS
//
//  Created by Andy Liang on 2019-09-22.
//  Copyright © 2019 Matt Donnelly. All rights reserved.
//

import UIKit
import SwifteriOS

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        // handle url
        Swifter.handleOpenURL(url, callbackURL: url)
    }
}
