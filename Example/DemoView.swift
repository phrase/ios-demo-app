//
//  AppDelegate.swift
//  Example
//
//  Copyright © 2023 Memsource GmbH. All rights reserved.
//

import Foundation
import UIKit

class DemoView: UIView {
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        setupLayout()
        setupStyling()
    }

    private func setupLayout() {
        titleLabel = UILabel()
        descriptionLabel = UILabel()

        addSubview(titleLabel)
        addSubview(descriptionLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupStyling() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .black
    }

    func update(title: String) {
        titleLabel.text = title
    }

    func update(description: String) {
        descriptionLabel.text = description
    }
}
