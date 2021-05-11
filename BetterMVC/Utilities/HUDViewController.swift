//
//  HUDViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import UIKit

final class HUDViewController: UIViewController {
    
    var text: String? {
        didSet {
            label?.text = text
        }
    }
    private var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hudView = UIView()
        if #available(iOS 13.0, *) {
            hudView.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
        }
        hudView.translatesAutoresizingMaskIntoConstraints = false
        hudView.layer.cornerRadius = 24
        
        view.alpha = 0.1
        
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label = label
        
        view.addSubview(hudView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            hudView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            hudView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            hudView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            hudView.heightAnchor.constraint(equalToConstant: 55),
            
            label.centerXAnchor.constraint(equalTo: hudView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: hudView.centerYAnchor)
        ])
    }
    
}
