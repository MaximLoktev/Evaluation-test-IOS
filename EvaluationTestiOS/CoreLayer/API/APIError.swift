//
//  APIError.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import Foundation

enum APIError: Error {
    case network(Error)
    case decoding(Error)
    case internalMessage(String)
}
