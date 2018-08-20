import Foundation

public final class API {
    public let token: String
    public init(token: String) {
        self.token = token
        
        iso8601 = DateFormatter()
        iso8601.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
        
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(iso8601)
    }
    
    private let iso8601: DateFormatter
    private let decoder: JSONDecoder
    
    public enum Error: Swift.Error {
        case parsing(Swift.Error)
        case noResponse
        case noData
        case notFound
        case unauthorized
        case badStatus(Int)
    }
    
    public enum Result<T> {
        case success(T)
        case failure(Swift.Error)
    }
    
    public typealias Completion<T> = (Result<T>) -> Void
    
    public func stores(completion: @escaping Completion<[Store]>) {
        get("/inventories/stores/search", completion: completion)
    }
    
    public func employees(completion: @escaping Completion<[Employee]>) {
        get("/inventories/employees/search", completion: completion)
    }
    
    public func devices(completion: @escaping Completion<[Device]>) {
        get("/inventories/devices/search", completion: completion)
    }
    
    public func products(of store: String, completion: @escaping Completion<[Product]>) {
        get("/inventories/stores/\(store)/products", completion: completion)
    }
    
    public func documents(
        of store: String,
        on device: String? = nil,
        after: Date? = nil,
        before: Date? = nil,
        types: [DocumentType] = [],
        completion: @escaping Completion<[Document]>
        ) {
        var params: [String: String] = [:]
        
        if let device = device {
            params["deviceUuid"] = device
        }
        if let after = after {
            params["gtCloseDate"] = iso8601.string(from: after)
        }
        if let before = before {
            params["ltCloseDate"] = iso8601.string(from: before)
        }
        if types.count > 0 {
            params["types"] = types.map({ $0.rawValue }).joined(separator: ",")
        }
        
        get("/inventories/stores/\(store)/documents", params: params, completion: completion)
    }
    
    private func get<T: Decodable>(_ path: String, params: [String: String] = [:], completion: @escaping Completion<T>) {
        var comps = URLComponents(string: "https://api.evotor.ru/api/v1\(path)")!
        comps.queryItems = params.reduce(into: [], { $0.append(URLQueryItem(name: $1.key, value: $1.value)) })

        var request = URLRequest(url: comps.url!)
        request.addValue(token, forHTTPHeaderField: "X-Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(Error.noResponse))
                return
            }
            
            guard 200 ..< 300 ~= response.statusCode else {
                switch response.statusCode {
                case 401:
                    completion(.failure(Error.unauthorized))
                case 404:
                    completion(.failure(Error.notFound))
                default:
                    completion(.failure(Error.badStatus(response.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(Error.noData))
                return
            }
            
            do {
                let value = try self.decoder.decode(T.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(Error.parsing(error)))
            }
        }
        task.resume()
    }
}
