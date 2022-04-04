//
//  MetaWeather_API.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import Foundation
import Alamofire

let BASE_URL = "https://www.metaweather.com/api/"

enum Router: URLRequestConvertible {
    case serchLocaion(query: String)
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
            case .serchLocaion:
                return "location/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .serchLocaion: return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
            case let .serchLocaion(query):
                var params = Parameters()
                params["query"] = query
                return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
            case .serchLocaion:
                request = try URLEncoding.default.encode(request, with: parameters)
        }
        return request
    }
}
