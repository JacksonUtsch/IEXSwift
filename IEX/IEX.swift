//
//  Copyright © 2020 Jackson Utsch.
//
//  Licensed under the MIT license.
//

import Foundation

public class IEX {
    public var apiKey: String
    
    public var baseURL: Base
    public var version: Version
    
    public static var shared: IEX?
    
    public init(apiKey: String) {
        self.apiKey = apiKey

        baseURL = .cloud
        version = .stable
    }
    
    func getEndpoint<T: Decodable>(_ path: String, as type: T.Type) -> T? {
        do {
            let data = try getJSON(from: path)
            
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                print("errored path: \(path)")
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    public enum Base: String {
        case cloud = "https://cloud.iexapis.com"
        case sandbox = "https://sandbox.iexapis.com"
    }

    public enum Version: String, RawRepresentable {
        case stable
        case latest
        case v1
    }
    
}

enum JSONError: Error {
    case invalidURL
}

/// retrieves JSON from string url
func getJSON(from stringURL: String) throws -> Data {
    var jsonData: Data?
    var jsonError: Error?
    
    /// semaphore awaits return til URLSession is fetched
    let sem = DispatchSemaphore.init(value: 0)
    
    guard let url = URL(string: stringURL) else {
        throw JSONError.invalidURL
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        defer { sem.signal() }
        
        if error != nil {
            jsonError = error
        }
        
        jsonData = data
        
    }.resume()
    
    sem.wait()
    
    if jsonData != nil {
        return jsonData!
    }
    
    throw jsonError!
}

extension String {
    static func / (left: String, right: String) -> String {
        return left + "/" + right
    }
    
    static func & (left: String, right: String) -> String {
        return left + "&" + right
    }
}
