import Foundation

public enum ReceiptType: String, Decodable {
    case sell = "SELL"
    case payback = "PAYBACK"
}

public enum PaymentSource: String, Decodable {
    case payCash = "PAY_CASH"
    case payCashback = "PAY_CASHBACK"
    case payCard = "PAY_CARD"
    case other = "OTHER"
}

public struct Receipt: Decodable {
    public struct Data: Decodable {
        public struct Position: Decodable {
            public let id: String
            public let name: String
            public let itemType: ProductType
            public let measureName: String
            public let quantity: Double
            public let price: Double
            public let costPrice: Double
            public let sumPrice: Double
            public let tax: Double
            public let taxPercent: Double
            public let discount: Double
        }
        
        public let id: String
        public let deviceId: String
        public let storeId: String
        public let dateTime: Date
        public let type: ReceiptType
        public let shiftId: String
        public let employeeId: String
        public let paymentSource: PaymentSource
        public let infoCheck: Bool
        public let egais: Bool
        public let items: [Position]
        public let totalTax: Double
        public let totalDiscount: Double
        public let totalAmount: Double
    }
    
    public let id: String
    public let timestamp: Int
    public let userId: String
    public let type: String
    public let version: Int
    public let data: Data
}
