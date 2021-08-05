//
//  LoadingViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

final class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

    private func configureHierarchy() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        view.addSubview(spinner)

        // Center our spinner both horizontally & vertically
        spinner.anchorCenter(to: view)
    }

}
