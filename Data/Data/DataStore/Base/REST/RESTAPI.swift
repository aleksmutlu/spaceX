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
        let details: String?
        let dateString: String?
        let missionName: String?
        let links: Links?
        let rocketName: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case details
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
                patchImageURLString: links?.patch?.patchURLString
            )
        }
    }


final class RESTAPI {
    
    
    func makeRequest(onCompletion: @escaping (Result<[LaunchResponse], Error>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches/past") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                onCompletion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let json = try! JSONDecoder().decode([LaunchResponse].self, from: data)

            onCompletion(.success(json))
        }
        task.resume()    
    }
}
