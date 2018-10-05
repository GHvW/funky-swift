import XCTest
@testable import funky_swift

final class funky_swiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(funky_swift().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
