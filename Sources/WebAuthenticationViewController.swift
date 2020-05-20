//
//  WebAuthenticationViewController.swift
//  SwifteriOS
//
//  Created by Huiping Guo on 2020/01/14.
//  Copyright © 2020 Matt Donnelly. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class WebAuthenticationViewController: UIViewController {
    
    let queryUrl: URL
    
    let dismissHandler: (() -> Void)?
    
    init(queryUrl: URL, dismissHandler: (() -> Void)? = nil) {
        self.queryUrl = queryUrl
        self.dismissHandler = dismissHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        embedViewController(viewController: createWebViewController())
    }
    
    func embedViewController(viewController: UIViewController) {
        guard let subview = viewController.view, let superview = view else { return }
        
        addChild(viewController)
        view.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        
        viewController.didMove(toParent: self)
    }
    
    func createWebViewController() -> SFSafariViewController {
        let safariView = SFSafariViewController(url: queryUrl)
        safariView.delegate = self
        safariView.modalTransitionStyle = .coverVertical
        safariView.modalPresentationStyle = .overFullScreen
        return safariView
    }
}

extension WebAuthenticationViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismissHandler?()
    }
    
}
