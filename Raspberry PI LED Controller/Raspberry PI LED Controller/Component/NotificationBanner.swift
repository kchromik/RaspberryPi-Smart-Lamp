//
//  NotificationBanner.swift
//  Raspberry PI LED Controller
//
//  Created by Kevin Chromik on 23.10.19.
//  Copyright © 2019 Kevin Chromik. All rights reserved.
//

import UIKit

class NotificationBanner: UIView {

    enum State {
        case info
        case success
        case failure
    }

    private let appWindow: UIWindow = UIApplication.shared.windows.last!
    private let height = Int(UIDevice.topInset + 50)
    private lazy var startFrame = CGRect(x: 0, y: -height, width: Int(appWindow.frame.width), height: height)
    private lazy var expandedFrame = CGRect(x: 0, y: 0, width: Int(appWindow.frame.width), height: height)

    private var state: State

    private var color: UIColor {
        switch state {
        case .info:
            return .gray
        case .success:
            return UIColor(red: 239/255, green: 65/255, blue: 56/255, alpha: 1.0)
        case .failure:
            return UIColor(red: 239/255, green: 65/255, blue: 56/255, alpha: 1.0)
        }
    }

    init(with text: String, for state: State) {
        self.state = state
        super.init(frame: .zero)

        self.frame = startFrame
        backgroundColor = .clear
        viewSetup(with: text, for: state)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func viewSetup(with text: String?, for state: State) {
        let containerView = UIView()
        addSubview(containerView)
        containerView.roundCorners(to: 25)
        containerView.backgroundColor = color
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel(frame: .zero)
        label.text = text
        label.font = UIFont(name: "Menlo-Bold", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: UIDevice.topInset + 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    func show() {
        DispatchQueue.main.async {
            self.appWindow.addSubview(self)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.frame = self.expandedFrame
            }) { _ in
                UIView.animate(withDuration: 0.1, delay: 2, options: .curveEaseIn, animations: {
                    self.frame = self.startFrame
                }, completion: { _ in
                    self.removeFromSuperview()
                })
            }
        }
    }
}
