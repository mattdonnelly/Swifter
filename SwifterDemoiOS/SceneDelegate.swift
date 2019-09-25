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
        guard let context = URLContexts.first else { return }
        if authorizationMode.isUsingSSO {
            let callbackUrl = URL(string: "swifter-nLl1mNYc25avPPF4oIzMyQzft://")!
            Swifter.handleOpenURL(context.url, callbackURL: callbackUrl, isSSO: true)
        } else {
            // ... Web
            let callbackUrl = URL(string: "swifter://")!
            Swifter.handleOpenURL(context.url, callbackURL: callbackUrl)
        }
    }
}
