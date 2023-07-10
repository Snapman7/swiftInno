//
//  APITarget.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 08.07.2023.
//

import Moya

enum APITarget {
    case getCharacters(page: Int)
}

extension APITarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else {
            fatalError("Не можем получить юрл")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case let .getCharacters(page):
            return .requestParameters(parameters: [
                "page" : page
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
            return ["Content-type": "application/json",
                    "Cache-Control" : "no-cache"]
    }
    
}



