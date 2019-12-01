//
//  ViewModel.swift
//  Raspberry PI LED Controller
//
//  Created by Kevin Chromik on 21.10.19.
//  Copyright © 2019 Kevin Chromik. All rights reserved.
//

import Foundation

enum State: String {
    case on
    case off
}

struct LampStatus: Codable {
    let status: Bool
}

class ViewModel {

    var date = Date()
    let url = URL(string: "http://raspberrypi.local:8080/")!
    var output: (() -> (String))?

    func `switch`(to state: State, completion: @escaping (Bool) -> ()) {
        URLSession.shared.dataTask(with: url.appendingPathComponent("led/\(state.rawValue)")) { (json, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    NotificationBanner(with: error.localizedDescription, for: .failure).show()
                }
            }

            let success = error == nil
            completion(success)
        }.resume()
    }

    func change(hue: Int, saturation: Int, brightness: Int) {
        let now = Date()
        guard now.timeIntervalSince(date) > 0.2 else {
            return
        }
        URLSession.shared.dataTask(with: url.appendingPathComponent("color/\(hue)/\(saturation)/\(brightness)")).resume()
        date = now
    }

    func isOn(completion: @escaping (Bool) -> ()) {
        URLSession.shared.dataTask(with: url.appendingPathComponent("led/status")) { (json, response, error) in
            completion(true)
        }.resume()
    }
}
