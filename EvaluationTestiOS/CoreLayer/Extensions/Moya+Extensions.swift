//
//  Moya+Extensions.swift
//  Evaluation Test iOS
//
//  Created by Максим Локтев on 12.12.2020.
//

import Moya

public extension Response {
    
    func mapObject<T: Codable>(_ type: T.Type, path: String? = nil) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .millisecondsSince1970
        do {
            return try decoder.decode(T.self, from: try getJsonData(path))
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }

    func getJsonData(_ path: String? = nil) throws -> Data {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            if let path = path {
                
                guard let specificObject = jsonObject.value(forKeyPath: path) else {
                    throw MoyaError.jsonMapping(self)
                }
                
                jsonObject = specificObject as AnyObject
            }
            
            return try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }
}

public extension MoyaProvider {
    
    @discardableResult
    internal func request<T: Codable>(_ target: Target,
                                      objectModel: T.Type,
                                      path: String? = nil,
                                      result: @escaping (_ returnData: Result<T, APIError>) -> Void) -> Cancellable? {
        
        return request(target, completion: { resulT in
    
            switch resulT {
            case .success(let response):
               if let successResponse = try? response.filterSuccessfulStatusCodes() {
                    do {
                        let returnData = try successResponse.mapObject(objectModel.self, path: path)
                        result(.success(returnData))
                    } catch {
                        result(.failure(.decoding(error)))
                    }
                }
            case .failure(let error):
                result(.failure(.network(error)))
            }
        })
    }
}
