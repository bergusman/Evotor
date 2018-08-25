import Foundation

public struct Receipt: Decodable {
    public struct Data: Decodable {
        public struct Position: Decodable {
            
        }
        
        public let dateTime: Date
        public let items: [Position]
    }
    
    public let id: String
    public let timestamp: Int
    public let userId: String
    public let type: String
    public let version: Int
    public let data: Data
}
