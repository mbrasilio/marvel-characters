//
//  CharactersListViewModel.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 28/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import Foundation

public class CharactersListViewModel {
    // MARK: - Attributes
    private let charactersApi = CharactersApi()
    public var charactersList: [Character]?
    public var charactersListComplete: [Character]?
    public var specificVersionLoaded: Bool = false
    public var offset: Int = 0
    
    // MARK: - Functions
    public func getCharactersList(_ nameStartsWith: String, _ isASpecificSearch: Bool, action: @escaping () -> Void) {
        if isASpecificSearch {
            self.offset = 0
        } else if specificVersionLoaded {
            self.charactersListComplete = []
        }
        
        charactersApi.getCharactersList(nameStartsWith: nameStartsWith, offset: self.offset) { [weak self] list in
            guard let wSelf = self else { return }
            wSelf.charactersList = list
            wSelf.specificVersionLoaded = isASpecificSearch
            if !isASpecificSearch {
                wSelf.offset += 20
                if wSelf.charactersListComplete != nil {
                    wSelf.charactersListComplete?.append(contentsOf: list ?? [])
                } else {
                    wSelf.charactersListComplete = list
                }
            } else {
                wSelf.charactersListComplete = list
            }
            action()
        }
    }
}
