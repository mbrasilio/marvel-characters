//
//  CharactersApi.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 28/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import Foundation
import CryptoKit

class CharactersApi {
    // MARK: - Api Attributes
    fileprivate let baseUrl: String = "https://gateway.marvel.com/v1/public/characters"
    fileprivate let publicKey: String = "5f67268ae01fb9807317c9c7962d34af"
    fileprivate let privateKey: String = "2881934b5bdcbe14c0fed4f0923c67796826fab1"
    fileprivate let timestamp: String = "\(NSDate().timeIntervalSince1970)"
    
    // MARK: - Api Functions
    public func getCharactersList(nameStartsWith: String, offset: Int, escaping: @escaping ([Character]?) -> Void) {
        // MARK: Session Config
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConfig)
        var urlString = baseUrl + "?ts=" + timestamp + "&apikey=" + publicKey + "&hash=" + getHash() + "&limit=20" + "&offset=\(offset)"
        if !nameStartsWith.isEmpty {
            let formattedString = nameStartsWith.replacingOccurrences(of: " ", with: "%20")
            urlString += "&nameStartsWith=\(formattedString)"
        }
        let url = URL(string: urlString)!
        
        // MARK: Request Config
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                escaping(nil)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode != 200 {
                        print("## error, httpStatus == \(statusCode) ##")
                        escaping(nil)
                    } else {
                        do {
                            if let data = data {
                                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                if let dict = json as? [String: AnyObject] {
                                    if let characters = dict["data"]?["results"] as? [Dictionary<String, AnyObject>] {
                                        var characterList: [Character] = []
                                        for item in characters {
                                            characterList.append(Character.parserCharacter(dict: item))
                                        }
                                        escaping(characterList)
                                    }
                                }
                            }
                        } catch {
                            print("## getCharactersList error ##")
                            escaping(nil)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

extension CharactersApi {
    public func getHash() -> String{
        let message: String = timestamp + privateKey + publicKey
        let digest = Insecure.MD5.hash(data: message.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
