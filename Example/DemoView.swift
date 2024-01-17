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
    private var button: UIButton!

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
        button = UIButton(type: .system)

        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(button)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            button.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupStyling() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 4
    }

    func update(title: String) {
        titleLabel.text = title
    }

    func update(description: String) {
        descriptionLabel.text = description
    }

    func update(buttonText: String) {
        button.setTitle(buttonText, for: .normal)
    }

    func setButton(action: @escaping () -> Void) {
        button.addAction(.init(handler: { _ in
            action()
        }), for: .touchUpInside)
    }
}

@available(iOS 17.0, *)
#Preview {
    let demoView = DemoView()
    demoView.update(title: "Title")
    demoView.update(description: "Description")
    demoView.update(buttonText: "Button")

    return demoView
}
