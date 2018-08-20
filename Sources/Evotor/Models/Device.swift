public struct Device: Decodable {
    public let uuid: String
    public let code: String?
    public let name: String
    public let storeUuid: String
    public let timezoneOffset: Int
    public let imei: String
}
