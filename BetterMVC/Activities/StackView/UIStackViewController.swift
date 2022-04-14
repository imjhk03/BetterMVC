//
//  UIStackViewController.swift
//  BetterMVC
//
//  Created by Joohee Kim on 22. 04. 14..
//

import UIKit

final class UIStackViewController: UIViewController {
    
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "stackview"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25) {
            self.yellowView.isHidden.toggle()
        }
    }
    
}
