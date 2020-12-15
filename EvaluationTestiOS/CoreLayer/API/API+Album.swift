//
//  API+Album.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import Moya

enum API {
    
    enum Album: TargetType {
        
        case getAlbum(name: String)
        case getSongsFromAlbum(nameAlbum: String)
        
        var baseURL: URL {
            return Config.shared.apiUrl
        }
        
        var path: String {
            switch self {
            case .getAlbum:
                return "/search"
            case .getSongsFromAlbum:
                return "/search"
            }
        }
        
        var method: Moya.Method {
            switch self {
            case .getAlbum:
                return .get
            case .getSongsFromAlbum:
                return .get
            }
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case .getAlbum(let name):
                return .requestParameters(parameters: ["term": name, "entity": "album"],
                                          encoding: URLEncoding.queryString)
            case .getSongsFromAlbum(let nameAlbum):
                return .requestParameters(parameters: ["term": nameAlbum, "entity": "song"],
                                          encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return nil
        }
    }
}

extension API.Album {
    
    struct ResultsAlbums: Codable {
        let results: [Album]
    }
    
    struct Album: Codable {
        let collectionId: Int
        let artistName: String
        let collectionName: String
        let artworkUrl60: String
        let artworkUrl100: String
        let trackCount: Int
        let copyright: String
        let releaseDate: String
        let primaryGenreName: String
    }
    
    struct ResultsSongs: Codable {
        let results: [Song]
    }
    
    struct Song: Codable {
        let trackName: String
        let trackNumber: Int
        let trackTimeMillis: Int
    }
}
