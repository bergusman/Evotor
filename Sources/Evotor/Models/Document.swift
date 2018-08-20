import Foundation

public enum DocumentType: String, Decodable {
    case accept = "ACCEPT"
    case sell = "SELL"
    case buy = "BUY"
    case payback = "PAYBACK"
    case buyback = "BUYBACK"
    case cashIncome = "CASH_INCOME"
    case cashOutcome = "CASH_OUTCOME"
    case closeSession = "CLOSE_SESSION"
    case openSession = "OPEN_SESSION"
    case inventory = "INVENTORY"
    case writeOff = "WRITE_OFF"
    case `return` = "RETURN"
    case revaluation = "REVALUATION"
    case fprint = "FPRINT"
    case openTare = "OPEN_TARE"
}

public enum DocumentVersion: String, Decodable {
    case v1 = "V1"
    case v2 = "V2"
}

public struct Document: Decodable {
    public let uuid: String
    public let type: DocumentType
    public let transactions: [Transaction]
    public let deviceUuid: String
    public let closeDate: Date
    public let openDate: Date
    public let openUserCode: Int?
    public let openUserUuid: String
    public let closeUserCode: Int?
    public let closeUserUuid: String
    public let sessionUUID: String
    public let sessionNumber: String
    public let number: Int
    public let closeResultSum: String?
    public let closeSum: String?
    public let storeUuid: String
    public let version: DocumentVersion
}
