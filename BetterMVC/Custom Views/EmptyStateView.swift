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
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            messageLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

}
