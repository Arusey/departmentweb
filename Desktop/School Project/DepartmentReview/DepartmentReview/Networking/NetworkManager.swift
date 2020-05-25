//
//  NetworkManager.swift
//  DepartmentReview
//
//  Created by Kevin Lagat on 25/05/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import Foundation
import Moya
enum APIRequests {
    case registerUser(firstName: String, lastName: String, email: String, password: String)
    case loginUser(email: String, password: String)
}

extension APIRequests: TargetType {
    var baseURL: URL {
        return URL(string: "https://hudumammu.herokuapp.com/api/v1")!
    }
    
    var path: String {
        
        switch self {
        case .registerUser:
            return "/user/register/"
        case .loginUser:
            return "/user/login/"
            
        }
        
        
    }
    
    var method: Moya.Method {
        switch self {
        case .registerUser:
            return .post
        case .loginUser:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
        }
        return .requestPlain
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .registerUser(let firstName, let lastName, let email, let password):
            return [
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "password": password
            ]
            
        case .loginUser(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        }
    }
}
