import XCTest
@testable import TTT

class TTTTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(TTT().text, "Hello, World!")
    }


    static var allTests : [(String, (TTTTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
