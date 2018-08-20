public enum ProductType: String, Decodable {
    case normal = "NORMAL"
    case alcoholMarked = "ALCOHOL_MARKED"
    case alcoholNotMarked = "ALCOHOL_NOT_MARKED"
    case service = "SERVICE"
}

public enum Tax: String, Decodable {
    case noVat = "NO_VAT"
    case vat10 = "VAT_10"
    case vat18 = "VAT_18"
    case vat0 = "VAT_0"
    case vat18_118 = "VAT_18_118"
    case vat10_110 = "VAT_10_110"
}

public struct Product: Decodable {
    public let uuid: String
    public let name: String
    public let group: Bool
    public let parentUuid: String?
    public let type: ProductType?
    public let quantity: Double?
    public let measureName: String?
    public let tax: Tax?
    public let price: Double?
    public let allowToSell: Bool?
    public let costPrice: Double?
    public let description: String?
    public let articleNumber: String?
    public let code: String?
    public let barCodes: [String]?
    public let alcoCodes: [String]?
    public let alcoholProductKindCode: Int?
    public let alcoholByVolume: Double?
    public let tareVolume: Double?
}
