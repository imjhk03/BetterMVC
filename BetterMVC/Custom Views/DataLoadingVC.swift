//
//  DataLoadingVC.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

class DataLoadingViewController: UIViewController {
    
    private let loadingVC = LoadingViewController()
    
    func showLoadingView() {
        add(loadingVC)
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async { self.loadingVC.remove() }
    }
    
}
