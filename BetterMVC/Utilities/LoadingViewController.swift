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
        
        var spinner: UIActivityIndicatorView?
        
        if #available(iOS 13.0, *) {
            spinner = UIActivityIndicatorView(style: .medium)
        } else {
            // Fallback on earlier versions
            spinner = UIActivityIndicatorView(style: .gray)
        }
        spinner?.translatesAutoresizingMaskIntoConstraints = false
        spinner?.startAnimating()
        
        if let spinner = spinner {
        view.addSubview(spinner)
        
        // Center our spinner both horizontally & vertically
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        }
    }
    
}
