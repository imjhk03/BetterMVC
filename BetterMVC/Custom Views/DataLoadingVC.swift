//
//  DataLoadingVC.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

class DataLoadingViewController: UIViewController {
    
    private let loadingVC = LoadingViewController()
    private let hudVC = HUDViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func showLoadingView() {
        add(loadingVC)
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async { self.loadingVC.remove() }
    }
    
    func showHUDView(_ text: String?) {
        hudVC.text = text
        add(hudVC)
        
        UIView.animate(withDuration: 1) {
            self.hudVC.view.alpha = 1
        } completion: { _ in
            self.removeHUDView()
        }
    }
    
    private func removeHUDView() {
        UIView.animate(withDuration: 1) {
            self.hudVC.view.alpha = 0
        } completion: { _ in
            self.hudVC.remove()
        }
    }
    
}
