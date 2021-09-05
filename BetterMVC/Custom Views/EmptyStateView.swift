//
//  EmptyStateView.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 08. 04..
//

import UIKit

final class EmptyStateView: UIView {

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    private func configure() {
        addSubview(messageLabel)
        configureMessageLabel()
    }

    private func configureMessageLabel() {
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel

        messageLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 80))
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }

}
