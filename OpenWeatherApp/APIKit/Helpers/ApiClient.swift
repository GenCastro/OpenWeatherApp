//
//  ApiClient.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/28.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation
import RxSwift

struct RequestModel {
    
    var url: URL
    var parameters: [String : String] = ["APPID": "13ca73f238ac2584b011757f2bb80a76"]
    
    init(url: URL, parameters: [String : String]) {
        
        self.url = url
        self.parameters = self.parameters.merging(parameters, uniquingKeysWith: {(x,_) in x})
    }
    
}

enum APIResponse {
    case success(result: UnboxableDictionary)
    case failure(error: AppError)
}

enum AppError: Error, LocalizedError {
    case apiError(message: String)
    case unknownError
    case unboxFail
    
    var errorDescription: String? {
        switch self {
        case .apiError(let msg):
            return msg
        case .unboxFail:
            return "it is not your fault"
        case .unknownError:
            return "An unexpected error has occurred. please try again."
        }
    }
}

class ApiClient {
    
    private func createRequest(requestModel: RequestModel) -> URLRequest {
        
        guard var components = URLComponents(url: requestModel.url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(requestModel.url)")
        }
        
        components.queryItems = requestModel.parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        print("**** URL: \(finalURL.absoluteString)")
        return URLRequest(url: finalURL)
        
    }
    
    func performRequest(request: RequestModel) -> Observable<APIResponse> {
        
        return Observable.create { observer in
            
            guard let jsonData = self.load(filename: "jhb") else {
                observer.onError(AppError.unknownError)
                return Disposables.create {
                    //task.cancel()
                }
            }
            print("OnNext")
            observer.onNext(.success(result: jsonData));
            observer.onCompleted()
//            let task = URLSession.shared.dataTask(with: self.createRequest(requestModel: request), completionHandler: { data, response, error in
//
//                if let error = error {
//                    observer.onError(AppError.apiError(message: error.localizedDescription))
//                } else {
//                    guard let data = data else {
//                        return observer.onError(AppError.unknownError)
//                    }
//
//                    do {
//                        guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
//                            return observer.onError(AppError.unknownError)
//                        }
//
//                        if let jsonString = String(data: data, encoding: .utf8) {
//                            print(jsonString)
//                        }
//
//                        observer.onNext(.success(result: json));
//                        observer.onCompleted()
//                    } catch {
//                        observer.onError(AppError.unknownError)
//                    }
//                }
//
//            })
//
//            task.resume()
            
            return Disposables.create {
                //task.cancel()
            }
        }
    }
    
    func load(filename fileName: String) -> [String: Any]? {
        let sdkModule = Bundle(for: ApiClient.self)
        if let url = sdkModule.url(forResource: fileName, withExtension: "json")
        {
            print("file found")
            if let data = NSData(contentsOf: url) {
                do {
                    
                    let object = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
                    
                    guard let responseJson = object as? [String: Any] else {
                        return nil
                    }
                    
                    return responseJson
                    
                }
                catch {
                    print("Error!! Unable to parse  \(fileName).json")
                }
            }
        }
        return nil
    }
}
