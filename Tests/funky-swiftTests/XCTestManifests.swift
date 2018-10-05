import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(funky_swiftTests.allTests),
    ]
}
#endif