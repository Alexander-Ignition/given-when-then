import XCTest

open class TestCase: XCTestCase {

    public struct Failure {
        public let description: String
        public let filePath: String
        public let lineNumber: Int
        public let expected: Bool
    }

    public struct Context {
        public let name: String
        public var failures: [Failure] = []
    }

    private var contexts: [Context] = []

    open func context(_ name: String) {
        contexts.append(Context(name: name))
    }

    open func given(_ description: String = "") {
        context("Given: \(description)")
    }

    open func when(_ description: String = "") {
        context("When: \(description)")
    }

    open func then(_ description: String = "") {
        context("Then: \(description)")
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
        for context in contexts {
            XCTContext.runActivity(named: context.name) { _ -> Void in
                context.failures.forEach(recordFailure)
            }
        }
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

        if contexts.isEmpty {
            recordFailure(failure)
        } else {
            let lastIndex = contexts.index(before: contexts.endIndex)
            contexts[lastIndex].failures.append(failure)
        }
    }
}
