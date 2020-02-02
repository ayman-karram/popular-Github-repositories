//
//  NetworkServerClient.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

class NetworkManager {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /**
       Call this method to perfom a web service of type `ServiceProtocol`
       - Parameter type: is generic type should be a model that confirm to `Codable` protocol
       - Parameter completion: result of type `NetworkResponse`.
       */
    private func request<T>(type: T.Type,
                            service: ServiceProtocol,
                            completion: @escaping (NetworkServiceResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?,
                                                  response: HTTPURLResponse?,
                                                  error: Error?, completion: (NetworkServiceResponse<T>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }
        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.JSONDecoder)) }
            completion(.success(model))
        default:
            completion(.failure(.unknown))
        }
    }
}

//MARK:- Repositories Services
extension NetworkManager: PopularRepositoriesServiceProtocol {
    func getPopularRopositories(service: ServiceProtocol,
                                completion: @escaping (_ result: NetworkServiceResponse<SearchResponse>) -> ()) {
        self.request(type: SearchResponse.self, service: service, completion: completion)
    }
}
