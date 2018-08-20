import Foundation

public final class API {
    public let token: String
    public init(token: String) {
        self.token = token
    }
    
    public enum Result<T> {
        case success(T)
        case failure(Error)
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
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let value = try decoder.decode(T.self, from: data)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
