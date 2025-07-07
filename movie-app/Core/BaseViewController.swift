//
//  BaseViewController.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

import UIKit

class BaseViewController: UIViewController {
    var router: AppRouter {
        return AppRouter.shared
    }
    
    var props: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
