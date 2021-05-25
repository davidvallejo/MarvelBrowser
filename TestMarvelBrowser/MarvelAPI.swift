//
//  MarvelAPI.swift
//  TestMarvelMonolithic
//
//  Created by David Vallejo on 24/5/21.
//

import Foundation

final class MarvelApi {
func getCharacterList(offset: Int, limit: Int, completion: @escaping (Result<CharacterDataWrapper, RequestError>) -> Void) {
     let url = "https://gateway.marvel.com/v1/public/characters?offset=\(offset)&limit=\(limit)"
    APIClient().request(url: url) { result in
        return completion(result)
    }
}

func getCharacter(id: Int, completion: @escaping (Result<CharacterDataWrapper, RequestError>) -> Void) {
    let url = "https://gateway.marvel.com/v1/public/characters/\(id)"
    APIClient().request(url: url) { result in
        return completion(result)
   }
}
}

