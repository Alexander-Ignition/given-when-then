import XCTest

open class TestCase: XCTestCase {

    public struct Failure {
        public let description: String
        public let filePath: String
        public let lineNumber: Int
        public let expected: Bool
    }

    private var failures: [Failure] = []

    open var context: String? {
        didSet {
            guard let context = oldValue else { return }
            XCTContext.runActivity(named: context) { _ -> Void in
                failures.forEach(recordFailure)
            }
            failures.removeAll(keepingCapacity: true)
        }
    }

    open func given(_ description: String = "") {
        context = "Given: \(description)"
    }

    open func when(_ description: String = "") {
        context = "When: \(description)"
    }

    open func then(_ description: String = "") {
        context = "Then: \(description)"
    }

    open func recordFailure(_ record: Failure) {
        super.recordFailure(
            withDescription: record.description,
            inFile: record.filePath,
            atLine: record.lineNumber,
            expected: record.expected)
    }

    // MARK: - XCTestCase

    open override func tearDown() {
        context = nil
        super.tearDown()
    }

    open override func recordFailure(
        withDescription description: String,
        inFile filePath: String,
        atLine lineNumber: Int,
        expected: Bool
    ) {
        let failure = Failure(
            description: description,
            filePath: filePath,
            lineNumber: lineNumber,
            expected: expected)

        if context == nil {
            recordFailure(failure)
        } else {
            failures.append(failure)
        }
    }
}
