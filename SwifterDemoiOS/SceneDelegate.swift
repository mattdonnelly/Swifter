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
        // handle url
        web: do {
            let callbackUrl = URL(string: "swifter://")!
            Swifter.handleOpenUrl(context.url, callbackURL: callbackUrl)
        }
        sso: do {
            let callbackUrl = URL(string: "swifter-nLl1mNYc25avPPF4oIzMyQzft://")!
            Swifter.handleOpenUrl(context.url, callbackURL: callbackUrl, isSSO: true)
        }
    }
}
