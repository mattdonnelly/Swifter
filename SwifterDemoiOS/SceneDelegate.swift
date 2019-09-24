//
//  SceneDelegate.swift
//  SwifterDemoiOS
//
//  Created by beta on 2019/09/23.
//  Copyright © 2019 Matt Donnelly. All rights reserved.
//

import UIKit
import SwifteriOS

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for context in URLContexts {
            web: do {
                let callbackUrl = URL(string: "swifter://")!
                Swifter.handleOpenUrl(context.url, callbackUrl: callbackUrl)
            }
            sso: do {
                let callbackUrl = URL(string: "swifter-nLl1mNYc25avPPF4oIzMyQzft://")!
                Swifter.handleOpenUrlSSO(context.url, callbackUrl: callbackUrl)
            }   
        }
    }
}
