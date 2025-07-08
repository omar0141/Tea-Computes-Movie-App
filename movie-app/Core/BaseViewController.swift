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
    
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let navBar = navigationController?.navigationBar

        if offset > 1 {
            navBar?.barTintColor = .black
            navBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            navBar?.barTintColor = .white
            navBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
    override func viewDidLoad() {
        let navBar = navigationController?.navigationBar
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        navBar?.titleTextAttributes = textAttributes
        navBar?.barTintColor = .black
    }

}
