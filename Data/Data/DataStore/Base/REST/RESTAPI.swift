//
//  RESTAPI.swift
//  Data
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Domain
import Foundation


struct LaunchResponse: Decodable {
    
    struct Links: Decodable {
        
        let patch: Patch?
        
        struct Patch: Decodable {
            let patchURLString: String?
            
            enum CodingKeys: String, CodingKey {
                case patchURLString = "small"
            }
        }
    }
    
    
    let id: String?
    let detail: String?
    let dateString: String?
    let missionName: String?
    let links: Links?
    let rocketName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case detail = "details"
        case dateString = "date_utc"
        case missionName = "name"
        case links
        case rocketName = "rocket"
    }
    
    func toDomain() -> Launch {
        Launch(
            id: id,
            missionName: missionName,
            dateString: dateString,
            rocketName: rocketName,
            patchImageURLString: links?.patch?.patchURLString,
            detail: detail
        )
    }
}


final class RESTAPI {
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func decode<T: Decodable>(data: Data, resultType: T.Type) -> T? {
        try? decoder.decode(resultType, from: data)
    }
    
    func makeRequest<T: Requestable>(request: T, onCompletion: @escaping (Result<T.Response, Error>) -> Void) {
        
        let urlString = "https://api.spacexdata.com/v5/" + request.path
        var components = URLComponents(string: urlString)
        components?.queryItems = []
        
        guard let url = components?.url else { return }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error = error {
                onCompletion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }
            
            if let result = self!.decode(data: data, resultType: T.Response.self) {
                onCompletion(.success(result))
            } else {
                // TODO: Error
            }
        }
        task.resume()    
    }
}

protocol Requestable {
    associatedtype Response: Decodable
    
    var path: String { get }
}

struct FetchLaunchesRequest: Requestable {
    typealias Response = Array<LaunchResponse>
    
    var path: String { "launches/past" }
}

struct FetchLaunchRequest: Requestable {
    typealias Response = LaunchResponse
    
    var path: String { "launches/" + id }
    let id: String
}

