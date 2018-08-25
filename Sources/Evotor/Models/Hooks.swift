public struct HooksErrors: Encodable {
    public let errors: [HooksError]
}

public struct HooksError: Encodable {
    public let code: Int
    public let reason: String?
    public let subject: String?
    public let value: String?
}
