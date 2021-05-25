//
//  Network.swift
//  TestMarvelMonolithic
//
//  Created by David Vallejo on 24/5/21.
//

import Foundation

let PUBLIC_KEY = "b6e68be2cb21b6459a92f2dde233f890"
let PRIVATE_KEY = "631f6a9b460ab93b6ba0720eae7ebf629b032b55"
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

typealias ResultCallback<Value> = (Result<Value, RequestError>) -> Void

enum RequestError: String, Error {
    case invalidResponse = "The response from the server was invalid."
    case invalidData = "The data received from the server was invalid."
}

final class APIClient {
    func request<T: Decodable>(url: String, completion: @escaping ResultCallback<T>) {
        let timestamp = NSDate().timeIntervalSince1970
        let hash = MD5(string: "\(timestamp)\(PRIVATE_KEY)\(PUBLIC_KEY)")
        
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "ts", value: "\(timestamp)"),
                                          URLQueryItem(name: "apikey", value: PUBLIC_KEY),
                                          URLQueryItem(name: "hash", value: hash)]
        var urlComps = URLComponents(string: url)!
        queryItems.append(contentsOf: urlComps.queryItems ?? [])
        urlComps.queryItems = queryItems
        
        print(urlComps.url!.absoluteString)
        
        let task = URLSession.shared.dataTask(with: urlComps.url!) { data, response, error in
            if let _ = error {
                return completion(.failure(.invalidResponse))
            }
            
            guard let data = data else {
                return completion(.failure(.invalidResponse))
            }
            
            self.decode(data) { result in
                completion(result)
            }
        }
        
        task.resume()
    }
    
    func decode<T: Decodable>(_ data: Data, completion: @escaping ResultCallback<T>) {
        let decoder = JSONDecoder()
        do {
            var fromData = data
            if fromData.isEmpty {
                fromData = "{}".data(using: .utf8)!
            }
            let object = try decoder.decode(T.self, from: fromData)
            return completion(.success(object))
        } catch {
            return completion(.failure(.invalidData))
        }
    }
}

extension APIClient {
    private func MD5(string: String) -> String {
        let data = string.data(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        _ = data!.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data!.count), &digest)
        }

        return digest.reduce(into: "") { $0 += String(format: "%02x", $1) }
    }
}
