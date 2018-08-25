import Foundation

public enum Transaction: Decodable {
    case unknown
    
    case openSession(OpenSession)
    case closeSession(CloseSession)
    
    case documentOpen(DocumentOpen)
    case registerPosition(RegisterPosition)
    case discountPosition(DiscountPosition)
    case discountDocumentPosition(DiscountDocumentPosition)
    case discountDocument(DiscountDocument)
    case positionTax(PositionTax)
    case payment(Payment)
    case documentCloseFprint(DocumentCloseFprint)
    case documentClose(DocumentClose)
    
    public struct DiscountDocument: Decodable {
        public let type: String
    }
    
    public struct PositionTax: Decodable {
        public let type: String
    }
    
    public struct DiscountPosition: Decodable {
        public let type: String
    }
    
    public struct DiscountDocumentPosition: Decodable {
        public let type: String
    }
    
    public struct DocumentOpen: Decodable {
        public let type: String
    }
    
    public struct DocumentClose: Decodable {
        public let type: String
    }
    
    public struct DocumentCloseFprint: Decodable {
        public let type: String
    }
    
    public struct RegisterPosition: Decodable {
        public let type: String
    }
    
    public struct RegisterBills: Decodable {
        public let type: String
    }
    
    public struct CashIncome: Decodable {
        public let type: String
    }
    
    public struct CashOutcome: Decodable {
        public let type: String
    }
    
    public struct Inventory: Decodable {
        public let type: String
    }
    
    public struct Payment: Decodable {
        public let type: String
    }
    
    public struct OpenSession: Decodable {
        public let type: String
    }
    
    public struct CloseSession: Decodable {
        public let type: String
    }
    
    public struct FprintOpenSession: Decodable {
        public let type: String
    }
    
    public struct FprintXReport: Decodable {
        public let type: String
    }
    
    public struct FprintZReport: Decodable {
        public let type: String
    }
    
    public struct Revaluation: Decodable {
        public let type: String
    }
}

public extension Transaction {
    private enum CodingKeys: CodingKey {
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "DISCOUNT_DOCUMENT":
            self = .discountDocument(try DiscountDocument(from: decoder))
        case "DISCOUNT_POSITION":
            self = .discountDocument(try DiscountDocument(from: decoder))
        case "POSITION_TAX":
            self = .positionTax(try PositionTax(from: decoder))
        default:
            self = .unknown
        }
    }
}
