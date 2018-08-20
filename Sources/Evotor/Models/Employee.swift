public struct Employee: Decodable {
    public let uuid: String
    public let role: String
    public let name: String
    public let lastName: String?
    public let patronymicName: String?
    public let phone: String?
    public let code: String?
    public let stores: [String]
}
