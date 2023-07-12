//
//  NetworkManager.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 08.07.2023.
//

import Moya

protocol NetworkManagerProtocol {
    func fetchCharacters(on page: Int, completion: @escaping (Result<Characters, Error>) -> Void)
}

final class NetworkManger: NetworkManagerProtocol {

    private var provider = MoyaProvider<APITarget>()

    func fetchCharacters(on page: Int, completion: @escaping (Result<Characters, Error>) -> Void) {
        request(target: .getCharacters(page: page), completion: completion)
    }
}

private extension NetworkManger {

    func request<T:Decodable>(target: APITarget, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
