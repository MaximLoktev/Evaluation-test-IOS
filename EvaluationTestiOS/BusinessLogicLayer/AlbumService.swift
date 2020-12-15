//
//  AlbumService.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import Moya

protocol AlbumService {
    func getAlbums(name: String, completion: @escaping (Result<[AlbumModel], APIError>) -> Void)
    func getSongsFromAlbum(nameAlbum: String, completion: @escaping (Result<[SongModel], APIError>) -> Void)
}

final class AlbumServiceImpl: AlbumService {

    // MARK: - Properties
    
    private let provider: MoyaProvider<API.Album>
    
    // MARK: - Init
    
    init(provider: MoyaProvider<API.Album>) {
        self.provider = provider
    }
    
    func getAlbums(name: String, completion: @escaping (Result<[AlbumModel], APIError>) -> Void) {
        let query = API.Album.getAlbum(name: name)
        provider.request(query, objectModel: API.Album.ResultsAlbums.self) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let result):
                let mappedAlbum = self.mapAlbums(result: result)
                completion(.success(mappedAlbum))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSongsFromAlbum(nameAlbum: String, completion: @escaping (Result<[SongModel], APIError>) -> Void) {
        let query = API.Album.getSongsFromAlbum(nameAlbum: nameAlbum)
        provider.request(query, objectModel: API.Album.ResultsSongs.self) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let result):
                let mappedSong = self.mapSongs(result: result)
                completion(.success(mappedSong))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapAlbums(result: API.Album.ResultsAlbums) -> [AlbumModel] {
        
        var albums: [AlbumModel] = result.results.map { album in
            return AlbumModel(collectionId: album.collectionId,
                              artistName: album.artistName,
                              collectionName: album.collectionName,
                              artworkUrl60: album.artworkUrl60,
                              artworkUrl100: album.artworkUrl100,
                              trackCount: album.trackCount,
                              copyright: album.copyright,
                              releaseDate: convertDate(stringDate: album.releaseDate),
                              primaryGenreName: album.primaryGenreName)
        }
        
        albums.sort(by: { $0.collectionName < $1.collectionName })

        return albums
    }
    
    private func mapSongs(result: API.Album.ResultsSongs) -> [SongModel] {
        
        let songs: [SongModel] = result.results.map { song in
            
            return SongModel(trackName: song.trackName,
                             trackNumber: song.trackNumber,
                             trackTimeMillis: song.trackTimeMillis)
        }

        return songs
    }
    
    private func convertDate(stringDate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM yyyy"
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        
        if let date = dateFormatterGet.date(from: stringDate) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}
