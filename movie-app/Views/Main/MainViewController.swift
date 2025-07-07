//
//  MainViewController.swift
//  movie-app
//
//  Created by Omar on 06/07/2025.
//

import UIKit


class MainViewController: BaseViewController {
    
    @IBOutlet weak var submitButton: UIButton!

    @IBAction func onSubmit(_ sender: Any) {
        router.navigate(to: .details)
    }
}
