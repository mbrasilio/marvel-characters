//
//  Character.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 28/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import Foundation

public struct Character {
    let name: String
    let description: String
    let thumbnailURL: String
    let details: CharacterDetails
    
    public static func parserCharacter(dict: Dictionary<String, AnyObject>) -> Character {
        return Character(name: dict["name"] as? String ?? "",
                         description: dict["description"] as? String ?? "",
                         thumbnailURL: getThumbnail(dict),
                         details: getCharacterDetails(dict))
    }
    
    private static func getThumbnail(_ dict: Dictionary<String, AnyObject>) -> String {
        if let thumbnail = dict["thumbnail"] {
            let text = "\(thumbnail["path"] as? String ?? "").\(thumbnail["extension"] as? String ?? "")"
            return text.replacingOccurrences(of: "http", with: "https")
        }
        return ""
    }
    
    private static func getCharacterDetails(_ dict: Dictionary<String, AnyObject>) -> CharacterDetails {
        var details = CharacterDetails()
        if let comics = dict["comics"] {
            details.comics = comics["available"] as? Int ?? 0
        }
        if let series = dict["series"] {
            details.series = series["available"] as? Int ?? 0
        }
        if let stories = dict["stories"] {
            details.stories = stories["available"] as? Int ?? 0
        }
        if let events = dict["events"] {
            details.events = events["available"] as? Int ?? 0
        }
        if let urls = dict["urls"] as? [Dictionary<String, AnyObject>] {
            for item in urls {
                if let type = item["type"] as? String, type == "detail" {
                    details.moreDetailsURL = item["url"] as? String ?? ""
                }
            }
        }
        return details
    }
}

public struct CharacterDetails {
    var comics: Int = 0
    var series: Int = 0
    var stories: Int = 0
    var events: Int = 0
    var moreDetailsURL: String = ""
}
