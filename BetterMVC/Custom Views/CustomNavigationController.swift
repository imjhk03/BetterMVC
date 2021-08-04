//
//  CustomNavigationController.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 04. 17..
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable ? navigationController?.viewControllers.count ?? 0 > 1 : false

        let viewControllersCount = navigationController?.viewControllers.count ?? 0
        navigationController?.interactivePopGestureRecognizer?.isEnabled = viewControllersCount > 1
    }

}

extension CustomNavigationController: UIGestureRecognizerDelegate {

}

extension CustomNavigationController: UINavigationControllerDelegate {
    // Fix bug when pop gesture is enabled for the root controller
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = viewControllers.count > 1
    }
}
