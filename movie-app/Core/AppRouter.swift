//
//  AppRouter.swift
//  movie-app
//
//  Created by Omar on 06/07/2025.
//

import UIKit

enum StoryBoardRoutes: String, CaseIterable {
    case home = "MainViewController"
    case details = "DetailsViewController"
}


class AppRouter {
    static let shared = AppRouter()
    private var navigationController: UINavigationController?
    
    private init() {}
    
    func setNavigationController(_ navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func createViewController(for route: StoryBoardRoutes, data: [String: Any]? = nil) -> UIViewController? {
        var viewController: UIViewController?
        viewController = UIStoryboard.viewController(id: route.rawValue)
        if let detailsVC = viewController as? BaseViewController {
                    detailsVC.props = data
        }
        return viewController
    }
    
    // Navigate to a route
    func navigate(to route: StoryBoardRoutes, animated: Bool = true) {
        guard let viewController = createViewController(for: route) else { return }
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    // Navigate with data
    func navigate(to route: StoryBoardRoutes, data: [String: Any], animated: Bool = true) {
        guard let viewController = createViewController(for: route, data: data) else { return }
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    // Present modally
    func present(route: StoryBoardRoutes, animated: Bool = true) {
        guard let viewController = createViewController(for: route) else { return }
        let navController = UINavigationController(rootViewController: viewController)
        navigationController?.present(navController, animated: animated)
    }
    
    // Go back
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    // Go to root
    func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    // Replace current screen
    func replace(with route: StoryBoardRoutes, animated: Bool = true) {
        guard let viewController = createViewController(for: route) else { return }
        var viewControllers = navigationController?.viewControllers ?? []
        if !viewControllers.isEmpty {
            viewControllers.removeLast()
        }
        viewControllers.append(viewController)
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }
    
    // Dismiss modal
    func dismiss(animated: Bool = true) {
        navigationController?.dismiss(animated: animated)
    }

}


extension UIStoryboard {
    static func viewController(id: String) -> UIViewController {
        return UIStoryboard(name: id, bundle: nil).instantiateViewController(withIdentifier: id)
    }
}
