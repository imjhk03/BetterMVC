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
        hudView.backgroundColor = .systemBackground
        hudView.layer.cornerRadius = 24

        view.alpha = 0.1

        let label = UILabel()
        label.text = text
        label.textColor = .black

        self.label = label

        view.addSubview(hudView)
        view.addSubview(label)

        hudView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 24, left: 80, bottom: 0, right: 80), size: .init(width: 0, height: 55))
        label.anchorCenter(to: hudView)
    }

}
