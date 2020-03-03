//
//  NetworkService.swift
//  Translater
//
//  Created by David Grigoryan on 13/11/2019.
//  Copyright © 2019 David Grigoryan. All rights reserved.
//

import Foundation

private struct Response: Codable {
    let text: [String]
    let code: Int
    
    func isSuccess() -> Bool {
        return code == 200
    }
}

protocol NetworkServiceProtocol {
    func translate(request: TranslationRequest, completion: @escaping (String?, TranslationError?) -> Void)
}

private let apiKey = "trnsl.1.1.20191113T142242Z.a1b7ce902cc450e4.fcde49d821a0586a1c333d3cb98ad0b038b0ac78"

final class NetworkService: NetworkServiceProtocol {
    
    func translate(request: TranslationRequest, completion: @escaping (String?, TranslationError?) -> Void) {
        let urlString = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=\(apiKey)&text=\(request.expression)&lang=\(request.from)-\(request.to)"
        
        guard let encodingString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodingString) else {
                completion(nil, TranslationError.invalidServerUrl)
                return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                guard let error = error as NSError? else {
                    completion(nil, TranslationError.unknowServerError)
                    return
                }
                completion(nil, TranslationError.serverError(code: error.code, description: error.localizedDescription))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let translationResponse = try decoder.decode(Response.self, from: data)
                if translationResponse.isSuccess() {
                    completion(translationResponse.text.first, nil)
                } else {
                    completion(nil, TranslationError.serverError(code: translationResponse.code, description: nil))
                }
            } catch (let error){
                completion(nil, TranslationError.parsingError(reason: error.localizedDescription))
            }
        }
        task.resume()
    }
}
