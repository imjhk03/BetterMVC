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

//        navigationController?.hidesBarsOnSwipe = true
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)

//        navigationController?.interactivePopGestureRecognizer?.isEnabled = navigationController?.viewControllers.count ?? 0 > 1
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

//        navigationController?.interactivePopGestureRecognizer?.delegate = nil
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

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}

extension DataLoadingViewController: UIGestureRecognizerDelegate {

}
