//
//  MetaWeather_API.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import Foundation
import Alamofire

let BASE_URL = "https://www.metaweather.com/"

enum Router: URLRequestConvertible {
    case searchLocaion(query: String)
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
            case .searchLocaion:
                return "api/location/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .searchLocaion: return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
            case let .searchLocaion(query):
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
            case .searchLocaion:
                request = try URLEncoding.default.encode(request, with: parameters)

        }
        return request
    }
}
