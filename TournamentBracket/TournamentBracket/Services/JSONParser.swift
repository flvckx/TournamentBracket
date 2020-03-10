//
//  JSONParser.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 10/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import Foundation

protocol IJSONParser {
    associatedtype T: Decodable

    static func parseFileNamed(_ name: String) -> T?
}

final class JSONParser<T: Decodable>: IJSONParser {

    static func parseFileNamed(_ name: String) -> T? {
        guard let filePath = Bundle.main.path(forResource: name, ofType: "json") else { return nil }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("Error while mapping jSon: \(error)")
            return nil
        }
    }
}

