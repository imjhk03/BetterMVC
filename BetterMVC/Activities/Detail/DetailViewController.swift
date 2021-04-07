//
//  DetailViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

final class DetailViewController: DataLoadingViewController {
    
    private let logic = DetailLogicController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        render(.loading)
        
        logic.load { [weak self] state in
            self?.render(state)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemPink
    }

}

// MARK: - Render
private extension DetailViewController {
    private func render(_ state: MovieDetail.State) {
        switch state {
        case .loading:
            showLoadingView()
        case .presenting(let detail):
            hideLoadingView()
            
//            dataSource.movies = list
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
        case .failed:
            hideLoadingView()
            
            print("Failed to load")
        }
    }
}
