//
//  Config.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import Foundation

final class Config {
    
    static let shared: Config = .init()
    
    let apiUrl: URL = URL(string: "https://itunes.apple.com")!
}
