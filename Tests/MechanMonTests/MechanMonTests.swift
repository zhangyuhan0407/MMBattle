import XCTest
@testable import MechanMon

class MechanMonTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(MechanMon().text, "Hello, World!")
    }


    static var allTests : [(String, (MechanMonTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
